package alternativa.protocol.codec.complex
{
    import alternativa.protocol.ICodec;
    import flash.utils.ByteArray;
    import alternativa.protocol.impl.LengthCodecHelper;
    import alternativa.protocol.ProtocolBuffer;
    import alternativa.protocol.IProtocol;

    public class ByteArrayCodec implements ICodec 
    {


        public function encode(_arg_1:ProtocolBuffer, _arg_2:Object):void
        {
            var _local_3:ByteArray = ByteArray(_arg_2);
            LengthCodecHelper.encodeLength(_arg_1, _local_3.length);
            _arg_1.writer.writeBytes(_local_3);
        }

        public function decode(_arg_1:ProtocolBuffer):Object
        {
            var _local_2:int = LengthCodecHelper.decodeLength(_arg_1);
            var _local_3:ByteArray = new ByteArray();
            if (_local_2 > 0)
            {
                _arg_1.reader.readBytes(_local_3, 0, _local_2);
            };
            return (_local_3);
        }

        public function init(_arg_1:IProtocol):void
        {
        }


    }
}