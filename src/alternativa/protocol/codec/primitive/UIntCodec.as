package alternativa.protocol.codec.primitive
{
    import alternativa.protocol.ICodec;
    import alternativa.protocol.ProtocolBuffer;
    import alternativa.protocol.IProtocol;

    public class UIntCodec implements ICodec 
    {


        public function encode(_arg_1:ProtocolBuffer, _arg_2:Object):void
        {
            _arg_1.writer.writeUnsignedInt(uint(_arg_2));
        }

        public function decode(_arg_1:ProtocolBuffer):Object
        {
            return (_arg_1.reader.readUnsignedInt());
        }

        public function init(_arg_1:IProtocol):void
        {
        }


    }
}