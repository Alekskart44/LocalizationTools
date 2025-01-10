package _codec.platform.client.core.general.resourcelocale.format
{
    import alternativa.protocol.ICodec;
    import alternativa.protocol.info.TypeCodecInfo;
    import platform.client.core.general.resourcelocale.format.StringPair;
    import alternativa.protocol.codec.OptionalCodecDecorator;
    import alternativa.protocol.IProtocol;
    import alternativa.protocol.impl.LengthCodecHelper;
    import __AS3__.vec.Vector;
    import alternativa.protocol.ProtocolBuffer;
    import __AS3__.vec.*;

    public class VectorCodecStringPairLevel1 implements ICodec 
    {

        private var elementCodec:ICodec;
        private var optionalElement:Boolean;

        public function VectorCodecStringPairLevel1(_arg_1:Boolean)
        {
            this.optionalElement = _arg_1;
        }

        public function init(_arg_1:IProtocol):void
        {
            this.elementCodec = _arg_1.getCodec(new TypeCodecInfo(StringPair, false));
            if (this.optionalElement)
            {
                this.elementCodec = new OptionalCodecDecorator(this.elementCodec);
            };
        }

        public function decode(_arg_1:ProtocolBuffer):Object
        {
            var _local_2:int = LengthCodecHelper.decodeLength(_arg_1);
            var _local_3:Vector.<StringPair> = new Vector.<StringPair>(_local_2, true);
            var _local_4:int;
            while (_local_4 < _local_2)
            {
                _local_3[_local_4] = StringPair(this.elementCodec.decode(_arg_1));
                _local_4++;
            };
            return (_local_3);
        }

        public function encode(_arg_1:ProtocolBuffer, _arg_2:Object):void
        {
            var _local_4:StringPair;
            if (_arg_2 == null)
            {
                throw (new Error("Object is null. Use @ProtocolOptional annotation."));
            };
            var _local_3:Vector.<StringPair> = Vector.<StringPair>(_arg_2);
            var _local_5:int = _local_3.length;
            LengthCodecHelper.encodeLength(_arg_1, _local_5);
            var _local_6:int;
            while (_local_6 < _local_5)
            {
                this.elementCodec.encode(_arg_1, _local_3[_local_6]);
                _local_6++;
            };
        }


    }
}