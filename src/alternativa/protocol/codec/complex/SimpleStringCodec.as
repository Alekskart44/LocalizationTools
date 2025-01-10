package alternativa.protocol.codec.complex
{
    import alternativa.protocol.ICodec;
    import flash.utils.ByteArray;
    import alternativa.protocol.info.TypeCodecInfo;
    import alternativa.types.Byte;
    import alternativa.protocol.IProtocol;
    import alternativa.protocol.ProtocolBuffer;

    public class SimpleStringCodec implements ICodec 
    {

        private var byteCodec:ICodec;
        private var buffer:ByteArray = new ByteArray();

        public function SimpleStringCodec(_arg_1:IProtocol)
        {
            this.byteCodec = _arg_1.getCodec(new TypeCodecInfo(Byte, false));
        }

        public function encode(_arg_1:ProtocolBuffer, _arg_2:Object):void
        {
        }

        public function decode(_arg_1:ProtocolBuffer):Object
        {
            var _local_2:int = int(this.byteCodec.decode(_arg_1));
            this.buffer.clear();
            _arg_1.reader.readBytes(this.buffer, 0, _local_2);
            return (this.buffer.toString());
        }

        public function init(_arg_1:IProtocol):void
        {
        }


    }
}