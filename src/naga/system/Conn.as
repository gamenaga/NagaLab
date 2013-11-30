package naga.system
{
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.net.FileReference;
	import flash.net.Socket;
	
	
	public class Conn
	{
		private static const a:String = "Conn";
		private static var conn:SQLConnection;
		public function Conn()
		{
			
		}
		public static function openConn():void{
			var filee : FileReference = new FileReference();
			conn = new SQLConnection();
			trace(a,24,conn.hasEventListener(SQLEvent.RESULT));
			var file : File = File.applicationStorageDirectory.resolvePath("/Users/zhangnaga/百度云同步盘/MobileGame/GuessWF/src/pt.db");
//			var file : File = File.applicationStorageDirectory.resolvePath("D:/手机游戏/GuessWF/src/pt.db");
			try{
				trace("Conn 26:	open db",file.nativePath);
				conn.open(file);
				
			}catch(error:SQLError){
				trace(error.message);
				trace(error.details);
			}
		}
		
		private static function onInsert(e:SQLEvent, fn:Function, para:Array):void
		{
			if (para.lenght == 2)
			{
				fn.call(null, para[0], para[1]);
			}
			else if (para.lenght == 1)
			{
				fn.call(null, para[0]);
			}
			else if (para.lenght == 3)
			{
				fn.call(null, para[0], para[1], para[2]);
			}
			else if (para.lenght == 4)
			{
				fn.call(null, para[0], para[1], para[2], para[4]);
			}
			trace(a,38,"RESULT!",e.target);	
		}
		
		public static function excuteSql(sqlstr:String):void{
			openConn();
			trace("Conn 37:	excuteSql",sqlstr);
			var stmt:SQLStatement = new SQLStatement();
			try{
				stmt.sqlConnection = conn;
				stmt.text = sqlstr;
				stmt.execute();
				var a:SQLResult = stmt.getResult();
			}catch(error:SQLError){
				trace(error.message);
				trace(error.details);
			}
		}
		
//		public function findFlowModel(fmId : Number) : FlowModel{
//			openConn();
//			var stmt:SQLStatement = new SQLStatement();
//			var sqlstr : String ="select * from flowmodel where fm_id = "+fmId;
//			var flowModel : FlowModel = null;
//			try{
//				stmt.sqlConnection = conn;
//				stmt.text = sqlstr;
//				stmt.execute();
//				var result:SQLResult = stmt.getResult();
//				if(result.data !=null){
//					flowModel  = new FlowModel(result.data[0]);
//					trace(flowModel.fmName);
//				}
//			}catch(error:SQLError){
//				trace(error.message);
//				trace(error.details);
//			} 
//			return flowModel;
//		}
//		public function findFlowXian(fmId : Number) : ArrayCollection{
//			openConn();
//			var stmt:SQLStatement = new SQLStatement();
//			var sqlstr : String ="select * from fmxian where fm_id = "+fmId;
//			var arrXian : ArrayCollection;
//			try{
//				stmt.sqlConnection = conn;
//				stmt.text = sqlstr;
//				stmt.execute();
//				var result:SQLResult = stmt.getResult();
//				if(result.data!=null){
//					arrXian =  new ArrayCollection();
//					var numResults:int = result.data.length;
//					for(var i:int = 0;i<numResults; i++){
//						var obj:Object = result.data[i];
//						var xian : FmXian = new FmXian(obj);
//						arrXian.addItem(xian);
//					}
//				}
//			}catch(error:SQLError){
//				trace(error.message);
//				trace(error.details);
//			} 
//			return arrXian;
//		}
//		public function findFlowNode(fmId : Number) : ArrayCollection{
//			openConn();
//			var stmt:SQLStatement = new SQLStatement();
//			var sqlstr : String ="select * from fmnodes where fm_id = "+fmId;
//			var arrNode : ArrayCollection ;
//			try{
//				stmt.sqlConnection = conn;
//				stmt.text = sqlstr;
//				stmt.execute();
//				var result:SQLResult = stmt.getResult();
//				if(result.data !=null){
//					arrNode = new ArrayCollection();
//					var numResults:int = result.data.length;
//					for(var i:int = 0;i<numResults; i++){
//						var obj:Object = result.data[i];
//						var node : FmNodes = new FmNodes(obj);
//						arrNode.addItem(node);
//						
//					}
//				}
//			}catch(error:SQLError){
//				trace(error.message);
//				trace(error.details);
//			} 
//			return arrNode;
//		}
		
		
		public static function selectSql(sql:String) : SQLResult
		{
			openConn();
			var stmt:SQLStatement = new SQLStatement();
			try{
				stmt.sqlConnection = conn;
				stmt.text = sql;
				trace("conn 128 :	",stmt.text);
				stmt.execute();
				var result : SQLResult = stmt.getResult(); 
				closeConn();
//				trace("conn 132 :	",result,result.data,result.lastInsertRowID);
				return  result;				
			}catch(error:SQLError){
				trace("conn 135 :	",error.message);
				trace("conn 136 :	",error.details);
			}
			return null ;
		}
		
		public static function insertSql(sql:String, fn:Function, para:Array) : Number{
			openConn();
			var stmt:SQLStatement = new SQLStatement();
			try{
				stmt.sqlConnection = conn;
				stmt.text = sql;
				trace("conn 151 :	",stmt.text);
				EventManager.AddEventFn(conn,SQLEvent.RESULT,onInsert,[fn,para],true);
				stmt.execute();
				var result : SQLResult = stmt.getResult(); 
				var primaryKey:Number = result.lastInsertRowID;
				closeConn();
				return  primaryKey;				
			}catch(error:SQLError){
				trace("conn 158 :	",error.message);
				trace("conn 159 :	",error.details);
			}
			return 0 ;
		}
		
		public static function closeConn():void{
			conn.close();
		}
		
	}
}