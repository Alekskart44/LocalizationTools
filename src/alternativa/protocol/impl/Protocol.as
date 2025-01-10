package alternativa.protocol.impl
{
    import alternativa.protocol.IProtocol;
    import flash.utils.Dictionary;
    import alternativa.protocol.info.TypeCodecInfo;
    import alternativa.protocol.codec.primitive.IntCodec;
    import alternativa.types.Short;
    import alternativa.protocol.codec.primitive.ShortCodec;
    import alternativa.types.Byte;
    import alternativa.protocol.codec.primitive.ByteCodec;
    import alternativa.types.UShort;
    import alternativa.protocol.codec.primitive.UShortCodec;
    import alternativa.protocol.codec.primitive.UIntCodec;
    import alternativa.protocol.codec.primitive.DoubleCodec;
    import alternativa.types.Float;
    import alternativa.protocol.codec.primitive.FloatCodec;
    import alternativa.protocol.codec.primitive.BooleanCodec;
    import alternativa.types.Long;
    import alternativa.protocol.codec.primitive.LongCodec;
    import alternativa.protocol.codec.complex.StringCodec;
    import flash.utils.ByteArray;
    import alternativa.protocol.codec.complex.ByteArrayCodec;
    import alternativa.protocol.codec.OptionalCodecDecorator;
    import alternativa.protocol.ICodecInfo;
    import alternativa.protocol.ICodec;
    import flash.utils.IDataOutput;
    import alternativa.protocol.ProtocolBuffer;
    import alternativa.protocol.CompressionType;
    import flash.utils.IDataInput;
    import alternativa.protocol.OptionalMap;
    import alternativa.protocol.*;

    public class Protocol implements IProtocol 
    {

        private static const LOG_CHANNEL:String = "protocol";
        public static var defaultInstance:IProtocol = new (Protocol)();

        private var info2codec:Object = new Object();
        private var listInitCodec:Dictionary = new Dictionary(false);

        public function Protocol()
        {
            this.registerCodec(new TypeCodecInfo(int, false), new IntCodec());
            this.registerCodec(new TypeCodecInfo(Short, false), new ShortCodec());
            this.registerCodec(new TypeCodecInfo(Byte, false), new ByteCodec());
            this.registerCodec(new TypeCodecInfo(UShort, false), new UShortCodec());
            this.registerCodec(new TypeCodecInfo(uint, false), new UIntCodec());
            this.registerCodec(new TypeCodecInfo(Number, false), new DoubleCodec());
            this.registerCodec(new TypeCodecInfo(Float, false), new FloatCodec());
            this.registerCodec(new TypeCodecInfo(Boolean, false), new BooleanCodec());
            this.registerCodec(new TypeCodecInfo(Long, false), new LongCodec());
            this.registerCodec(new TypeCodecInfo(String, false), new StringCodec());
            this.registerCodec(new TypeCodecInfo(ByteArray, false), new ByteArrayCodec());
            this.registerCodec(new TypeCodecInfo(int, true), new OptionalCodecDecorator(new IntCodec()));
            this.registerCodec(new TypeCodecInfo(Short, true), new OptionalCodecDecorator(new ShortCodec()));
            this.registerCodec(new TypeCodecInfo(Byte, true), new OptionalCodecDecorator(new ByteCodec()));
            this.registerCodec(new TypeCodecInfo(UShort, true), new OptionalCodecDecorator(new UShortCodec()));
            this.registerCodec(new TypeCodecInfo(uint, true), new OptionalCodecDecorator(new UIntCodec()));
            this.registerCodec(new TypeCodecInfo(Number, true), new OptionalCodecDecorator(new DoubleCodec()));
            this.registerCodec(new TypeCodecInfo(Float, true), new OptionalCodecDecorator(new FloatCodec()));
            this.registerCodec(new TypeCodecInfo(Boolean, true), new OptionalCodecDecorator(new BooleanCodec()));
            this.registerCodec(new TypeCodecInfo(Long, true), new OptionalCodecDecorator(new LongCodec()));
            this.registerCodec(new TypeCodecInfo(String, true), new OptionalCodecDecorator(new StringCodec()));
            this.registerCodec(new TypeCodecInfo(ByteArray, true), new OptionalCodecDecorator(new ByteArrayCodec()));
        }

        public function registerCodec(_arg_1:ICodecInfo, _arg_2:ICodec):void
        {
            this.info2codec[_arg_1] = _arg_2;
        }

        public function registerCodecForType(_arg_1:Class, _arg_2:ICodec):void
        {
            this.info2codec[new TypeCodecInfo(_arg_1, false)] = _arg_2;
            this.info2codec[new TypeCodecInfo(_arg_1, true)] = new OptionalCodecDecorator(_arg_2);
        }

        public function getCodec(_arg_1:ICodecInfo):ICodec
        {
            var _local_2:ICodec = this.info2codec[_arg_1];
            if (_local_2 == null)
            {
                throw (Error(("Codec not found for  " + _arg_1)));
            };
            if (this.listInitCodec[_local_2] == null)
            {
                this.listInitCodec[_local_2] = _local_2;
                _local_2.init(this);
            };
            return (_local_2);
        }

        public function makeCodecInfo(_arg_1:Class):ICodecInfo
        {
            return (new TypeCodecInfo(_arg_1, false));
        }

        public function wrapPacket(_arg_1:IDataOutput, _arg_2:ProtocolBuffer, _arg_3:CompressionType):void
        {
            PacketHelper.wrapPacket(_arg_1, _arg_2, _arg_3);
        }

        public function unwrapPacket(_arg_1:IDataInput, _arg_2:ProtocolBuffer, _arg_3:CompressionType):Boolean
        {
            return (PacketHelper.unwrapPacket(_arg_1, _arg_2, _arg_3));
        }

        public function decode(_arg_1:Class, _arg_2:ByteArray):*
        {
            var _local_3:ICodec = this.getCodec(this.makeCodecInfo(_arg_1));
            var _local_4:ByteArray = new ByteArray();
            var _local_5:ProtocolBuffer = new ProtocolBuffer(_local_4, _local_4, new OptionalMap());
            this.unwrapPacket(_arg_2, _local_5, CompressionType.DEFLATE_AUTO);
            return (_local_3.decode(_local_5));
        }
		
        public function encode(_arg_1:Class, _arg_2:*):ByteArray
        {
            var _local_3:ICodec = this.getCodec(this.makeCodecInfo(_arg_1));
            var _local_4:ByteArray = new ByteArray();
            var _local_5:ProtocolBuffer = new ProtocolBuffer(_local_4, _local_4, new OptionalMap());
            _local_3.encode(_local_5, _arg_2);
            this.wrapPacket(_local_4, _local_5, CompressionType.DEFLATE_AUTO);
            return _local_4;
        }

    }
}