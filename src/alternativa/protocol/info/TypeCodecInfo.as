package alternativa.protocol.info
{
    import flash.utils.getQualifiedClassName;

    public class TypeCodecInfo extends CodecInfo 
    {

        private var _type:Class;

        public function TypeCodecInfo(_arg_1:Class, _arg_2:Boolean)
        {
            super(_arg_2);
            this._type = _arg_1;
        }

        public function get type():Class
        {
            return (this._type);
        }

        override public function toString():String
        {
            return ((("[TypeCodecInfo " + super.toString()) + " type=") + getQualifiedClassName(this.type));
        }


    }
}