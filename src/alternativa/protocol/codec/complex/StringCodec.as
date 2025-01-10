package alternativa.protocol.codec.complex
{
    import alternativa.protocol.ICodec;
    import flash.utils.ByteArray;
    import alternativa.protocol.impl.LengthCodecHelper;
    import alternativa.protocol.ProtocolBuffer;
    import alternativa.protocol.IProtocol;

    public class StringCodec implements ICodec 
    {


        public function encode(_arg_1:ProtocolBuffer, _arg_2:Object):void
        {
            var _local_3:ByteArray = new ByteArray();
            _local_3.writeUTFBytes(String(_arg_2));
            var _local_4:int = _local_3.length;
            LengthCodecHelper.encodeLength(_arg_1, _local_4);
            _arg_1.writer.writeBytes(_local_3, 0, _local_4);
        }

        public function decode(_arg_1:ProtocolBuffer):Object
        {
            var _local_2:int = LengthCodecHelper.decodeLength(_arg_1);
            return (_arg_1.reader.readUTFBytes(_local_2));
        }

        public function init(_arg_1:IProtocol):void
        {
        }


    }
}