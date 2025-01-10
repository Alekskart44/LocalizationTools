package alternativa.protocol
{
    public interface ICodec 
    {

        function init(_arg_1:IProtocol):void;
        function encode(_arg_1:ProtocolBuffer, _arg_2:Object):void;
        function decode(_arg_1:ProtocolBuffer):Object;

    }
}