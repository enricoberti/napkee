package com.napkee.dao
{
	import com.napkee.orm.EntityManager;
	
	import flash.data.SQLConnection;
	import flash.filesystem.File;
	
	public class DBManager
	{
		
		private static var instance:DBManager;
		private static var localInstantiation:Boolean = false;
		
		private static var sqlConnection:SQLConnection;
		private static var em:EntityManager = EntityManager.getInstance();	
		
		private static var applicationSettingsDAO:ApplicationSettingsDAO;
		
		
		public function DBManager()
		{
			if (!localInstantiation){
				throw new Error("EntityManager is a singleton. Use EntityManager.getInstance() to obtain an instance of this class.");
			}
			
		}
		
		private static function createSingleton():void
		{
			if (!instance)
			{
				localInstantiation = true;
				instance = new DBManager();
				initDatabase();
				applicationSettingsDAO = new ApplicationSettingsDAO(em);
				localInstantiation = false;
			}
		}
		
		public static function getInstance():DBManager
		{
			createSingleton();
			return instance;
		}
		
		private static function initDatabase():void
		{
			var file:File = File.applicationStorageDirectory.resolvePath("napkee.db");
			sqlConnection = new SQLConnection();
			sqlConnection.open(file);
			em.sqlConnection = sqlConnection;
		}
		
		public static function getApplicationSettingsDAO():ApplicationSettingsDAO
		{
			createSingleton();
			return applicationSettingsDAO;
		}

	}
}