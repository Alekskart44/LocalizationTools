package alternativa.protocol.codec.primitive
{
    import alternativa.protocol.ProtocolBuffer;
    import alternativa.protocol.IProtocol;

    public class DoubleCodec implements IPrimitiveCodec 
    {


        public function nullValue():Object
        {
            return (Number.NEGATIVE_INFINITY);
        }

        public function encode(_arg_1:ProtocolBuffer, _arg_2:Object):void
        {
            _arg_1.writer.writeDouble(Number(_arg_2));
        }

        public function decode(_arg_1:ProtocolBuffer):Object
        {
            return (_arg_1.reader.readDouble());
        }

        public function init(_arg_1:IProtocol):void
        {
        }


    }
}