package alternativa.protocol.codec.primitive
{
    import alternativa.protocol.ICodec;
    import alternativa.protocol.ProtocolBuffer;
    import alternativa.protocol.IProtocol;

    public class BooleanCodec implements ICodec 
    {


        public function encode(_arg_1:ProtocolBuffer, _arg_2:Object):void
        {
            _arg_1.writer.writeByte(((Boolean(_arg_2)) ? int(1) : int(0)));
        }

        public function decode(_arg_1:ProtocolBuffer):Object
        {
            return (!(_arg_1.reader.readByte() == 0));
        }

        public function init(_arg_1:IProtocol):void
        {
        }


    }
}