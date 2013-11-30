package naga.system
{
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.filesystem.File;
	
	import naga.ui.Dialog;
	
	public class Database
	{
		//		public function Database()
		//		{
		//			var conn:SQLConnection=new SQLConnection();
		//			var dbFile:File =File.applicationDirectory.resolvePath("School.db");
		//			conn.open(dbFile);
		//		}
		//		static public function connDB(DBFile:Text):void{
		//			
		//		}
		public static var con:SQLConnection;
		
		private static var createStmt:SQLStatement;
		
//		public function initApp():void
//		{
//			var file:File = File.applicationStorageDirectory.resolvePath("pt.rdb")
//			
//			con = new SQLConnection();
//			//在 openAsync() 方法调用操作成功完成时调度
//			con.addEventListener(SQLEvent.OPEN,openHandler);
//			//SQLConnection 对象的异步操作导致错误时调度
//			con.addEventListener(SQLErrorEvent.ERROR,errorHandler);
//			
//			con.openAsync(file);
//		}
		
//		public function openHandler(evt:SQLEvent):void
//		{
//			Dialog.add("成功完成");
//		}
//		
//		public function errorHandler(evt:SQLErrorEvent):void
//		{
//			Dialog.add("失败");
//			Dialog.add(evt.error.message);
//			Dialog.add(evt.error.details);
//		}
		public static function updateData():void
		{
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = con; 
			stmt.text="update save set save_data=:saveData";// where id=:ids";
			stmt.parameters[":saveData"]="1,1";
//			stmt.parameters[":ids"]=1;
			stmt.execute();
			
			var result:SQLResult = stmt.getResult(); 
			var count:Number = result.rowsAffected;
			
			Dialog.add("成功修改"+count.toString()+"行"); 
		}
		
		public static function query():void
		{
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = con; 
			stmt.text = "select save_data from save";
			//stmt.parameters[":id"]=1;
			stmt.execute();  
			
			var result:SQLResult = stmt.getResult();
			
			if ( result.data!=null )
			{
				var numResults:int =result.data.length;
				
				for (var i:int = 0; i < numResults; i++) 
				{ 
					var row:Object = result.data[i]; 
					var output:String = "save_data: " + row.save_data;
					Dialog.add(output);  
				} 
			}
		}
		
		public static function initApp():void
		{
			var file:File = File.applicationStorageDirectory.resolvePath("pt.db")
			
			con = new SQLConnection();
			createStmt = new SQLStatement();
			
			try
			{
				con.open(file);
				
				
				createStmt.sqlConnection = con; 
				var sql:String =  
					"CREATE TABLE IF NOT EXISTS save (" +  
					"    id INTEGER PRIMARY KEY AUTOINCREMENT" +  
					"    save_data TEXT CHECK (save_data <> '') " +  
					")"; 
				
				createStmt.text = sql;
				createStmt.execute();  
				
				Dialog.add("成功创建表");
			}
			catch(error:SQLError)
			{
				Dialog.add(error.message);
				Dialog.add(error.details);
			}
		}		
	} 
}
