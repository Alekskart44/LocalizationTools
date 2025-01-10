package alternativa.protocol.codec
{
    import alternativa.protocol.ICodec;
    import alternativa.protocol.codec.primitive.IPrimitiveCodec;
    import alternativa.protocol.ProtocolBuffer;
    import alternativa.protocol.IProtocol;

    public class OptionalCodecDecorator implements ICodec 
    {

        private var codec:ICodec;
        private var nullobject:Object;

        public function OptionalCodecDecorator(_arg_1:ICodec)
        {
            this.codec = _arg_1;
            if ((_arg_1 is IPrimitiveCodec))
            {
                this.nullobject = IPrimitiveCodec(_arg_1).nullValue();
            };
        }

        public function encode(_arg_1:ProtocolBuffer, _arg_2:Object):void
        {
            if (_arg_2 == this.nullobject)
            {
                _arg_1.optionalMap.addBit(true);
            }
            else
            {
                _arg_1.optionalMap.addBit(false);
                this.codec.encode(_arg_1, _arg_2);
            };
        }

        public function decode(_arg_1:ProtocolBuffer):Object
        {
            return ((_arg_1.optionalMap.get()) ? this.nullobject : this.codec.decode(_arg_1));
        }

        public function init(_arg_1:IProtocol):void
        {
            this.codec.init(_arg_1);
        }


    }
}