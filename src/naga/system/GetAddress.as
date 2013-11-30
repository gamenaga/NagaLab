package naga.system
{ 
	import flash.display.Sprite; 
	import flash.net.InterfaceAddress; 
	import flash.net.NetworkInfo; 
	import flash.net.NetworkInterface; 
	
	public class GetAddress extends Sprite 
	{ 
		public function GetAddress()
		{ 
			var networkInfo:NetworkInfo = NetworkInfo.networkInfo; 
			var interfaces:Vector.<NetworkInterface> = networkInfo.findInterfaces(); 
			
			if( interfaces != null ) 
			{ 
				trace( "Interface count: " + interfaces.length ); 
				for each ( var interfaceObj:NetworkInterface in interfaces ) 
				{ 
					trace( "\nname: "             + interfaceObj.name ); 
					trace( "display name: "     + interfaceObj.displayName ); 
					trace( "mtu: "                 + interfaceObj.mtu ); 
					trace( "active?: "             + interfaceObj.active ); 
					trace( "parent interface: " + interfaceObj.parent ); 
					trace( "hardware address: " + interfaceObj.hardwareAddress ); 
					if( interfaceObj.subInterfaces != null ) 
					{ 
						trace( "# subinterfaces: " + interfaceObj.subInterfaces.length ); 
					} 
					trace("# addresses: "     + interfaceObj.addresses.length ); 
					for each ( var address:InterfaceAddress in interfaceObj.addresses ) 
					{ 
						trace( "  type: "           + address.ipVersion ); 
						trace( "  address: "         + address.address ); 
						trace( "  broadcast: "         + address.broadcast ); 
						trace( "  prefix length: "     + address.prefixLength ); 
					} 
				}             
			} 
		}     
	}
}