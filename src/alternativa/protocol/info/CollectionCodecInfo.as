﻿package alternativa.protocol.info
{
    import alternativa.protocol.ICodecInfo;

    public class CollectionCodecInfo extends CodecInfo 
    {

        private var _elementCodec:ICodecInfo;
        private var _level:int;

        public function CollectionCodecInfo(_arg_1:ICodecInfo, _arg_2:Boolean, _arg_3:int)
        {
            super(_arg_2);
            this._elementCodec = _arg_1;
            this._level = _arg_3;
        }

        public function get level():int
        {
            return (this._level);
        }

        public function get elementCodec():ICodecInfo
        {
            return (this._elementCodec);
        }

        override public function toString():String
        {
            return (((((("[CollectionCodecInfo " + super.toString()) + " element=") + this.elementCodec.toString()) + " level=") + this.level) + "]");
        }


    }
}