package platform.client.core.general.resourcelocale.format
{
    public class LocalizedFileFormat 
    {

        private var _images:Vector.<ImagePair>;
        private var _strings:Vector.<StringPair>;

        public function LocalizedFileFormat(_arg_1:Vector.<ImagePair>=null, _arg_2:Vector.<StringPair>=null)
        {
            this._images = _arg_1;
            this._strings = _arg_2;
        }

        public function get images():Vector.<ImagePair>
        {
            return (this._images);
        }

        public function set images(_arg_1:Vector.<ImagePair>):void
        {
            this._images = _arg_1;
        }

        public function get strings():Vector.<StringPair>
        {
            return (this._strings);
        }

        public function set strings(_arg_1:Vector.<StringPair>):void
        {
            this._strings = _arg_1;
        }

        public function toString():String
        {
            var _local_1:String = "LocalizedFileFormat [";
            _local_1 = (_local_1 + (("images = " + this.images) + " "));
            _local_1 = (_local_1 + (("strings = " + this.strings) + " "));
            return (_local_1 + "]");
        }


    }
}