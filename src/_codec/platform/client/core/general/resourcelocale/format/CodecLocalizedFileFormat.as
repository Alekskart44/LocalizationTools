package _codec.platform.client.core.general.resourcelocale.format
{
    import alternativa.protocol.ICodec;
    import alternativa.protocol.info.CollectionCodecInfo;
    import alternativa.protocol.info.TypeCodecInfo;
    import platform.client.core.general.resourcelocale.format.ImagePair;
    import platform.client.core.general.resourcelocale.format.StringPair;
    import alternativa.protocol.IProtocol;
    import platform.client.core.general.resourcelocale.format.LocalizedFileFormat;
    import alternativa.protocol.ProtocolBuffer;
    import __AS3__.vec.*;

    public class CodecLocalizedFileFormat implements ICodec 
    {

        private var codec_images:ICodec;
        private var codec_strings:ICodec;


        public function init(_arg_1:IProtocol):void
        {
            this.codec_images = _arg_1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ImagePair, false), false, 1));
            this.codec_strings = _arg_1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(StringPair, false), false, 1));
        }

        public function decode(_arg_1:ProtocolBuffer):Object
        {
            var _local_2:LocalizedFileFormat = new LocalizedFileFormat();
            _local_2.images = (this.codec_images.decode(_arg_1) as Vector.<ImagePair>);
            _local_2.strings = (this.codec_strings.decode(_arg_1) as Vector.<StringPair>);
            return (_local_2);
        }

        public function encode(_arg_1:ProtocolBuffer, _arg_2:Object):void
        {
            if (_arg_2 == null)
            {
                throw (new Error("Object is null. Use @ProtocolOptional annotation."));
            };
            var _local_3:LocalizedFileFormat = LocalizedFileFormat(_arg_2);
            this.codec_images.encode(_arg_1, _local_3.images);
            this.codec_strings.encode(_arg_1, _local_3.strings);
        }


    }
}