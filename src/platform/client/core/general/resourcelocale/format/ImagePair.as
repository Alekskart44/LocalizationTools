package platform.client.core.general.resourcelocale.format
{
    import flash.utils.ByteArray;

    public class ImagePair 
    {

        private var _key:String;
        private var _value:ByteArray;

        public function ImagePair(_arg_1:String=null, _arg_2:ByteArray=null)
        {
            this._key = _arg_1;
            this._value = _arg_2;
        }

        public function get key():String
        {
            return (this._key);
        }

        public function set key(_arg_1:String):void
        {
            this._key = _arg_1;
        }

        public function get value():ByteArray
        {
            return (this._value);
        }

        public function set value(_arg_1:ByteArray):void
        {
            this._value = _arg_1;
        }

        public function toString():String
        {
            var _local_1:String = "ImagePair [";
            _local_1 = (_local_1 + (("key = " + this.key) + " "));
            _local_1 = (_local_1 + (("value = " + this.value) + " "));
            return (_local_1 + "]");
        }


    }
}