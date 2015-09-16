package com.napkee.utils
{
	public class TimeUtils
	{
		public function TimeUtils()
		{
		}
		
		public static const MILLIS_PER_DAY:int = 1000 * 60 * 60 * 24; 
		
		public static function getTimestamp(date:Date):String 
		{
			return  date.fullYear + "" + ((date.month+1)<10?"0":"") + (date.month+1) + "" + (date.date<10?"0":"") + date.date + "_"  + (date.hours<10?"0":"") + date.hours + "" + (date.minutes<10?"0":"") + date.minutes + "" + (date.seconds<10?"0":"") + date.seconds;
		}
		
		public static function getDaysDifference(minDate:Date, maxDate:Date):uint
		{ 
			return Math.ceil(( maxDate.getTime() - minDate.getTime()) / MILLIS_PER_DAY); 
		} 


	}
}