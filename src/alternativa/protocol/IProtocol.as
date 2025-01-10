package alternativa.protocol
{
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import flash.utils.ByteArray;

    public interface IProtocol 
    {

        function registerCodec(_arg_1:ICodecInfo, _arg_2:ICodec):void;
        function registerCodecForType(_arg_1:Class, _arg_2:ICodec):void;
        function getCodec(_arg_1:ICodecInfo):ICodec;
        function makeCodecInfo(_arg_1:Class):ICodecInfo;
        function wrapPacket(_arg_1:IDataOutput, _arg_2:ProtocolBuffer, _arg_3:CompressionType):void;
        function unwrapPacket(_arg_1:IDataInput, _arg_2:ProtocolBuffer, _arg_3:CompressionType):Boolean;
        function decode(_arg_1:Class, _arg_2:ByteArray):*;

    }
}