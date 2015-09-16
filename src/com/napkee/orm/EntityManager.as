package com.napkee.orm
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	
	public class EntityManager extends EventDispatcher
	{
		/* 	
			Map of metadata information for each class used by the application. The class is used as 
			the map key. The information maintained for each class includes: 
				table: name of the database table used to persist the object information.
				identity: object that maps the table primary key to the name of the corresponding class field.  
				fields: list of objects that map field names of the class to the corresponding database colums.
		*/
		private var map:Object = new Object();
		private var _sqlConnection:SQLConnection;

		private static var instance:EntityManager;		
		
		private static var localInstantiation:Boolean = false;
		
		// Constructor. Enforce the singleton pattern by throwing an error if the class is not instantiated using getInstance().
		public function EntityManager()
		{
			if (!localInstantiation)
			{
				throw new Error("EntityManager is a singleton. Use EntityManager.getInstance() to obtain an instance of this class.");
			}
		}
		
		public static function getInstance():EntityManager
		{
			if (!instance)
			{
				localInstantiation = true;
				instance = new EntityManager();
				localInstantiation = false;
			}
			return instance;
		}

		public function findAll(c:Class):ArrayCollection
		{
			// If not yet done, load the metadata for this class
			if (!map[c]) loadMetadata(c);
			var stmt:SQLStatement = map[c].findAllStmt;
			stmt.execute();
			// Return typed objects
			var result:Array = stmt.getResult().data;
			return typeArray(result, c);
		}
		
		public function getFirst(c:Class):Object
		{
			var results:ArrayCollection = findAll(c);
			if (results != null && results.length > 0)
				return results.getItemAt(0);
			else
				return null; 
		}
		
		public function getById(c:Class,id:int):Object
		{
			var results:ArrayCollection = findAll(c);
			if (results != null && results.length > 0){
				for (var i:int = 0; i<results.length; i++){
					if (results.getItemAt(i).id == id)
						return results.getItemAt(i);
				}
				return null;
			}
			else
				return null; 
		}
		
		public function save(o:Object):void
		{
			var c:Class = Class(getDefinitionByName(getQualifiedClassName(o)));
			// If not yet done, load the metadata for this class
			if (!map[c]) loadMetadata(c);
			var identity:Object = map[c].identity;
			// Check if the object has an identity
			if (o[identity.field]>0)
			{
				// If yes, we deal with an update
				updateItem(o,c);
			}
			else
			{
				// If no, this is a new item
				createItem(o,c);
			}
		}

		private function updateItem(o:Object, c:Class):void
		{
			var stmt:SQLStatement = map[c].updateStmt;
			var fields:ArrayCollection = map[c].fields;
			for (var i:int = 0; i<fields.length; i++)
			{
				var field:String = fields.getItemAt(i).field;
				stmt.parameters[":" + field] = o[field];
			}
			stmt.execute();
		}

		private function createItem(o:Object, c:Class):void
		{
			var stmt:SQLStatement = map[c].insertStmt;
			var identity:Object = map[c].identity;
			var fields:ArrayCollection = map[c].fields;
			for (var i:int = 0; i<fields.length; i++)
			{
				var field:String = fields.getItemAt(i).field;
				if (field != identity.field)
				{
					stmt.parameters[":" + field] = o[field];
				}
			}
			stmt.execute();
			o[identity.field] = stmt.getResult().lastInsertRowID;
		}
		
		public function remove(o:Object):void
		{
			var c:Class = Class(getDefinitionByName(getQualifiedClassName(o)));
			// If not yet done, load the metadata for this class
			if (!map[c]) loadMetadata(c);
			var identity:Object = map[c].identity;
			var stmt:SQLStatement = map[c].deleteStmt;
			stmt.parameters[":"+identity.field] = o[identity.field];
			stmt.execute();
		}
		
		private function loadMetadata(c:Class):void
		{
			map[c] = new Object();
			var xml:XML = describeType(new c());
			var table:String = xml.metadata.(@name=="Table").arg.(@key=="name").@value;
			map[c].table = table;
			map[c].fields = new ArrayCollection();
			var variables:XMLList = xml.accessor;

			var insertParams:String = "";
			var updateSQL:String = "UPDATE " + table + " SET ";
			var insertSQL:String = "INSERT INTO " + table + " (";
			var createSQL:String = "CREATE TABLE IF NOT EXISTS " + table + " (";

            for (var i:int = 0 ; i < variables.length() ; i++) 
            {
            	var field:String = variables[i].@name.toString();
				var column:String;            	
            	if (variables[i].metadata.(@name=="Column").length()>0)
            	{
            		column = variables[i].metadata.(@name=="Column").arg.(@key=="name").@value.toString(); 
            	} 
            	else
            	{
					column = field;
            	}
        		map[c].fields.addItem({field: field, column: column});

            	if (variables[i].metadata.(@name=="Id").length()>0)
            	{
            		map[c].identity = {field: field, column: column};
					createSQL += column + " INTEGER PRIMARY KEY AUTOINCREMENT,";
            	}
				else            	
				{
					insertSQL += column + ",";
					insertParams += ":" + field + ",";
					updateSQL += column + "=:" + field + ",";	
					createSQL += column + " " + getSQLType(variables[i].@type) + ",";
				}
            }
            
            createSQL = createSQL.substring(0, createSQL.length-1) + ")";
            
            insertSQL = insertSQL.substring(0, insertSQL.length-1) + ") VALUES (" + insertParams;
            insertSQL = insertSQL.substring(0, insertSQL.length-1) + ")";
            
			updateSQL = updateSQL.substring(0, updateSQL.length-1);
			updateSQL += " WHERE " + map[c].identity.column + "=:" + map[c].identity.field;

			var deleteSQL:String = "DELETE FROM " + table + " WHERE " + map[c].identity.column + "=:" + map[c].identity.field;

			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = insertSQL;
			map[c].insertStmt = stmt;
			
			stmt = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = updateSQL;
			map[c].updateStmt = stmt;
			
			stmt = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = deleteSQL;
			map[c].deleteStmt = stmt;
			
			stmt = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = "SELECT * FROM " + table;
			map[c].findAllStmt = stmt;

			stmt = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = createSQL;
			stmt.execute();
		}
		
		private function typeArray(a:Array, c:Class):ArrayCollection
		{
			if (a==null) return null;
			var ac:ArrayCollection = new ArrayCollection();
			for (var i:int=0; i<a.length; i++)
			{
				ac.addItem(typeObject(a[i],c));
			}
			return ac;			
		}

		private function typeObject(o:Object, c:Class):Object
		{
			var instance:Object = new c();
			var fields:ArrayCollection = map[c].fields;
			
			for (var i:int; i<fields.length; i++)
			{
				var item:Object = fields.getItemAt(i);
				instance[item.field] = o[item.column];	
			}
			return instance;
		}
		
		private function getSQLType(asType:String):String
		{
			if (asType == "int" || asType == "uint")
				return "INTEGER";
			else if (asType == "Number")
				return "REAL";
			else if (asType == "flash.utils::ByteArray")
				return "BLOB";
			else
				return "TEXT";				
		}
		
		public function set sqlConnection(sqlConnection:SQLConnection):void
		{
			_sqlConnection = sqlConnection;
		}
		
		public function get sqlConnection():SQLConnection
		{
			if (!_sqlConnection)
			{
				var dbFile:File = File.applicationStorageDirectory.resolvePath("default.db");  
				_sqlConnection = new SQLConnection(); 
				_sqlConnection.open(dbFile);
			}
			return _sqlConnection;
		}
		
	}
}