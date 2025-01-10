package _codec.platform.client.core.general.resourcelocale.format
{
    import alternativa.protocol.ICodec;
    import alternativa.protocol.info.TypeCodecInfo;
    import flash.utils.ByteArray;
    import alternativa.protocol.IProtocol;
    import platform.client.core.general.resourcelocale.format.ImagePair;
    import alternativa.protocol.ProtocolBuffer;

    public class CodecImagePair implements ICodec 
    {

        private var codec_key:ICodec;
        private var codec_value:ICodec;


        public function init(_arg_1:IProtocol):void
        {
            this.codec_key = _arg_1.getCodec(new TypeCodecInfo(String, false));
            this.codec_value = _arg_1.getCodec(new TypeCodecInfo(ByteArray, false));
        }

        public function decode(_arg_1:ProtocolBuffer):Object
        {
            var _local_2:ImagePair = new ImagePair();
            _local_2.key = (this.codec_key.decode(_arg_1) as String);
            _local_2.value = (this.codec_value.decode(_arg_1) as ByteArray);
            return (_local_2);
        }

        public function encode(_arg_1:ProtocolBuffer, _arg_2:Object):void
        {
            if (_arg_2 == null)
            {
                throw (new Error("Object is null. Use @ProtocolOptional annotation."));
            };
            var _local_3:ImagePair = ImagePair(_arg_2);
            this.codec_key.encode(_arg_1, _local_3.key);
            this.codec_value.encode(_arg_1, _local_3.value);
        }


    }
}