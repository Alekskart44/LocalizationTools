package platform.client.core.general.resourcelocale
{
    import alternativa.protocol.ICodec;
    import alternativa.protocol.IProtocol;
    import _codec.platform.client.core.general.resourcelocale.format.CodecImagePair;
	import alternativa.protocol.impl.Protocol;
    import alternativa.protocol.info.TypeCodecInfo;
    import platform.client.core.general.resourcelocale.format.ImagePair;
    import alternativa.protocol.codec.OptionalCodecDecorator;
    import _codec.platform.client.core.general.resourcelocale.format.CodecLocalizedFileFormat;
    import platform.client.core.general.resourcelocale.format.LocalizedFileFormat;
    import _codec.platform.client.core.general.resourcelocale.format.CodecStringPair;
    import platform.client.core.general.resourcelocale.format.StringPair;
    import _codec.platform.client.core.general.resourcelocale.format.VectorCodecImagePairLevel1;
    import alternativa.protocol.info.CollectionCodecInfo;
    import _codec.platform.client.core.general.resourcelocale.format.VectorCodecLocalizedFileFormatLevel1;
    import _codec.platform.client.core.general.resourcelocale.format.VectorCodecStringPairLevel1;

    public class Activator
	{
	
	public function start(protocol:Protocol):void
    {
            var _local_3:ICodec;
            var _local_2:IProtocol = protocol;
            _local_3 = new CodecImagePair();
            _local_2.registerCodec(new TypeCodecInfo(ImagePair, false), _local_3);
            _local_2.registerCodec(new TypeCodecInfo(ImagePair, true), new OptionalCodecDecorator(_local_3));
            _local_3 = new CodecLocalizedFileFormat();
            _local_2.registerCodec(new TypeCodecInfo(LocalizedFileFormat, false), _local_3);
            _local_2.registerCodec(new TypeCodecInfo(LocalizedFileFormat, true), new OptionalCodecDecorator(_local_3));
            _local_3 = new CodecStringPair();
            _local_2.registerCodec(new TypeCodecInfo(StringPair, false), _local_3);
            _local_2.registerCodec(new TypeCodecInfo(StringPair, true), new OptionalCodecDecorator(_local_3));
            _local_3 = new VectorCodecImagePairLevel1(false);
            _local_2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ImagePair, false), false, 1), _local_3);
            _local_2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ImagePair, false), true, 1), new OptionalCodecDecorator(_local_3));
            _local_3 = new VectorCodecImagePairLevel1(true);
            _local_2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ImagePair, true), false, 1), _local_3);
            _local_2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ImagePair, true), true, 1), new OptionalCodecDecorator(_local_3));
            _local_3 = new VectorCodecLocalizedFileFormatLevel1(false);
            _local_2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LocalizedFileFormat, false), false, 1), _local_3);
            _local_2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LocalizedFileFormat, false), true, 1), new OptionalCodecDecorator(_local_3));
            _local_3 = new VectorCodecLocalizedFileFormatLevel1(true);
            _local_2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LocalizedFileFormat, true), false, 1), _local_3);
            _local_2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LocalizedFileFormat, true), true, 1), new OptionalCodecDecorator(_local_3));
            _local_3 = new VectorCodecStringPairLevel1(false);
            _local_2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(StringPair, false), false, 1), _local_3);
            _local_2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(StringPair, false), true, 1), new OptionalCodecDecorator(_local_3));
            _local_3 = new VectorCodecStringPairLevel1(true);
            _local_2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(StringPair, true), false, 1), _local_3);
            _local_2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(StringPair, true), true, 1), new OptionalCodecDecorator(_local_3));
        }

    }
}