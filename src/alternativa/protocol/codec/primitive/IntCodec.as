package alternativa.protocol.codec.primitive
{
    import alternativa.protocol.ProtocolBuffer;
    import alternativa.protocol.IProtocol;

    public class IntCodec implements IPrimitiveCodec 
    {


        public function nullValue():Object
        {
            return (int.MIN_VALUE);
        }

        public function encode(_arg_1:ProtocolBuffer, _arg_2:Object):void
        {
            _arg_1.writer.writeInt(int(_arg_2));
        }

        public function decode(_arg_1:ProtocolBuffer):Object
        {
            return (_arg_1.reader.readInt());
        }

        public function init(_arg_1:IProtocol):void
        {
        }


    }
}