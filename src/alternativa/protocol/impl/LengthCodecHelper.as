package alternativa.protocol.impl
{
    import alternativa.protocol.ProtocolBuffer;

    public class LengthCodecHelper 
    {


        public static function encodeLength(_arg_1:ProtocolBuffer, _arg_2:int):void
        {
            var _local_3:Number;
            if (_arg_2 < 0)
            {
                throw (new Error((("Length is incorrect (" + _arg_2) + ")")));
            };
            if (_arg_2 < 128)
            {
                _arg_1.writer.writeByte(int((_arg_2 & 0x7F)));
            }
            else
            {
                if (_arg_2 < 0x4000)
                {
                    _local_3 = ((_arg_2 & 0x3FFF) + 0x8000);
                    _arg_1.writer.writeByte(int(((_local_3 & 0xFF00) >> 8)));
                    _arg_1.writer.writeByte(int((_local_3 & 0xFF)));
                }
                else
                {
                    if (_arg_2 < 0x400000)
                    {
                        _local_3 = ((_arg_2 & 0x3FFFFF) + 0xC00000);
                        _arg_1.writer.writeByte(int(((_local_3 & 0xFF0000) >> 16)));
                        _arg_1.writer.writeByte(int(((_local_3 & 0xFF00) >> 8)));
                        _arg_1.writer.writeByte(int((_local_3 & 0xFF)));
                    }
                    else
                    {
                        throw (new Error((("Length is incorrect (" + _arg_2) + ")")));
                    };
                };
            };
        }

        public static function decodeLength(_arg_1:ProtocolBuffer):int
        {
            var _local_4:int;
            var _local_5:Boolean;
            var _local_6:int;
            var _local_2:int = _arg_1.reader.readByte();
            var _local_3:Boolean = ((_local_2 & 0x80) == 0);
            if (_local_3)
            {
                return (_local_2);
            };
            _local_4 = _arg_1.reader.readByte();
            _local_5 = ((_local_2 & 0x40) == 0);
            if (_local_5)
            {
                return (((_local_2 & 0x3F) << 8) + (_local_4 & 0xFF));
            };
            _local_6 = _arg_1.reader.readByte();
            return ((((_local_2 & 0x3F) << 16) + ((_local_4 & 0xFF) << 8)) + (_local_6 & 0xFF));
        }


    }
}