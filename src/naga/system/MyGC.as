package naga.system
{
	import flash.net.LocalConnection;

    public class MyGC
    {

        public static function GC() : void
        {
            var _loc_1:LocalConnection;
            var _loc_2:LocalConnection;
            try
            {
                _loc_1 = new LocalConnection();
                _loc_2 = new LocalConnection();
                _loc_1.connect("na");
                _loc_2.connect("ga");
            }
            catch (e:Error)
            {
            }
        }// end function

    }
}
