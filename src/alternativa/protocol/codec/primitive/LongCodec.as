package alternativa.protocol.codec.primitive
{
    import alternativa.protocol.ICodec;
    import alternativa.types.Long;
    import alternativa.protocol.ProtocolBuffer;
    import alternativa.protocol.IProtocol;

    public class LongCodec implements ICodec 
    {


        public function encode(_arg_1:ProtocolBuffer, _arg_2:Object):void
        {
            _arg_1.writer.writeInt(Long(_arg_2).high);
            _arg_1.writer.writeInt(Long(_arg_2).low);
        }

        public function decode(_arg_1:ProtocolBuffer):Object
        {
            return (Long.getLong(_arg_1.reader.readInt(), _arg_1.reader.readInt()));
        }

        public function init(_arg_1:IProtocol):void
        {
        }


    }
}