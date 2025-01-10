package alternativa.protocol.impl
{
    import flash.utils.ByteArray;
    import alternativa.protocol.OptionalMap;
    import flash.utils.IDataInput;

    public class OptionalMapCodecHelper 
    {

        private static const INPLACE_MASK_FLAG:int = 128;
        private static const MASK_LENGTH_2_BYTES_FLAG:int = 64;
        private static const INPLACE_MASK_1_BYTES:int = 32;
        private static const INPLACE_MASK_3_BYTES:int = 96;
        private static const INPLACE_MASK_2_BYTES:int = 64;
        private static const MASK_LENGTH_1_BYTE:int = 128;
        private static const MASK_LEGTH_3_BYTE:int = 0xC00000;


        public static function encodeNullMap(_arg_1:OptionalMap, _arg_2:ByteArray):void
        {
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_3:int = _arg_1.getSize();
            var _local_4:ByteArray = _arg_1.getMap();
            if (_local_3 <= 5)
            {
                _arg_2.writeByte(int(((_local_4[0] & 0xFF) >>> 3)));
            }
            else
            {
                if (_local_3 <= 13)
                {
                    _arg_2.writeByte(int((((_local_4[0] & 0xFF) >>> 3) + INPLACE_MASK_1_BYTES)));
                    _arg_2.writeByte((((_local_4[1] & 0xFF) >>> 3) + (_local_4[0] << 5)));
                }
                else
                {
                    if (_local_3 <= 21)
                    {
                        _arg_2.writeByte(int((((_local_4[0] & 0xFF) >>> 3) + INPLACE_MASK_2_BYTES)));
                        _arg_2.writeByte(int((((_local_4[1] & 0xFF) >>> 3) + (_local_4[0] << 5))));
                        _arg_2.writeByte(int((((_local_4[2] & 0xFF) >>> 3) + (_local_4[1] << 5))));
                    }
                    else
                    {
                        if (_local_3 <= 29)
                        {
                            _arg_2.writeByte(int((((_local_4[0] & 0xFF) >>> 3) + INPLACE_MASK_3_BYTES)));
                            _arg_2.writeByte(int((((_local_4[1] & 0xFF) >>> 3) + (_local_4[0] << 5))));
                            _arg_2.writeByte(int((((_local_4[2] & 0xFF) >>> 3) + (_local_4[1] << 5))));
                            _arg_2.writeByte(int((((_local_4[3] & 0xFF) >>> 3) + (_local_4[2] << 5))));
                        }
                        else
                        {
                            if (_local_3 <= 504)
                            {
                                _local_5 = ((_local_3 >>> 3) + (((_local_3 & 0x07) == 0) ? 0 : 1));
                                _local_6 = int(((_local_5 & 0xFF) + MASK_LENGTH_1_BYTE));
                                _arg_2.writeByte(_local_6);
                                _arg_2.writeBytes(_local_4, 0, _local_5);
                            }
                            else
                            {
                                if (_local_3 <= 0x2000000)
                                {
                                    _local_5 = ((_local_3 >>> 3) + (((_local_3 & 0x07) == 0) ? 0 : 1));
                                    _local_7 = (_local_5 + MASK_LEGTH_3_BYTE);
                                    _local_6 = int(((_local_7 & 0xFF0000) >>> 16));
                                    _local_8 = int(((_local_7 & 0xFF00) >>> 8));
                                    _local_9 = int((_local_7 & 0xFF));
                                    _arg_2.writeByte(_local_6);
                                    _arg_2.writeByte(_local_8);
                                    _arg_2.writeByte(_local_9);
                                    _arg_2.writeBytes(_local_4, 0, _local_5);
                                }
                                else
                                {
                                    throw (new Error("NullMap overflow"));
                                };
                            };
                        };
                    };
                };
            };
        }

        public static function decodeNullMap(_arg_1:IDataInput, _arg_2:OptionalMap):void
        {
            var _local_4:int;
            var _local_7:int;
            var _local_8:Boolean;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_3:ByteArray = new ByteArray();
            var _local_5:int = _arg_1.readByte();
            var _local_6:Boolean = (!((_local_5 & INPLACE_MASK_FLAG) == 0));
            if (_local_6)
            {
                _local_7 = (_local_5 & 0x3F);
                _local_8 = (!((_local_5 & MASK_LENGTH_2_BYTES_FLAG) == 0));
                if (_local_8)
                {
                    _local_10 = _arg_1.readByte();
                    _local_11 = _arg_1.readByte();
                    _local_4 = (((_local_7 << 16) + ((_local_10 & 0xFF) << 8)) + (_local_11 & 0xFF));
                }
                else
                {
                    _local_4 = _local_7;
                };
                _arg_1.readBytes(_local_3, 0, _local_4);
                _local_9 = (_local_4 << 3);
                _arg_2.init(_local_9, _local_3);
                return;
            };
            _local_7 = int((_local_5 << 3));
            _local_4 = int(((_local_5 & 0x60) >> 5));
            switch (_local_4)
            {
                case 0:
                    _local_3.writeByte(_local_7);
                    _arg_2.init(5, _local_3);
                    return;
                case 1:
                    _local_10 = _arg_1.readByte();
                    _local_3.writeByte(int((_local_7 + ((_local_10 & 0xFF) >>> 5))));
                    _local_3.writeByte(int((_local_10 << 3)));
                    _arg_2.init(13, _local_3);
                    return;
                case 2:
                    _local_10 = _arg_1.readByte();
                    _local_11 = _arg_1.readByte();
                    _local_3.writeByte(int((_local_7 + ((_local_10 & 0xFF) >>> 5))));
                    _local_3.writeByte(int(((_local_10 << 3) + ((_local_11 & 0xFF) >>> 5))));
                    _local_3.writeByte(int((_local_11 << 3)));
                    _arg_2.init(21, _local_3);
                    return;
                case 3:
                    _local_10 = _arg_1.readByte();
                    _local_11 = _arg_1.readByte();
                    _local_12 = _arg_1.readByte();
                    _local_3.writeByte(int((_local_7 + ((_local_10 & 0xFF) >>> 5))));
                    _local_3.writeByte(int(((_local_10 << 3) + ((_local_11 & 0xFF) >>> 5))));
                    _local_3.writeByte(int(((_local_11 << 3) + ((_local_12 & 0xFF) >>> 5))));
                    _local_3.writeByte(int((_local_12 << 3)));
                    _arg_2.init(29, _local_3);
                    return;
            };
            throw (new Error("Invalid OptionalMap"));
        }


    }
}