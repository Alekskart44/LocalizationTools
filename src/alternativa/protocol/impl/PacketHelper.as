package alternativa.protocol.impl
{
    import flash.utils.ByteArray;
    import alternativa.protocol.CompressionType;
    import flash.utils.IDataInput;
    import alternativa.protocol.ProtocolBuffer;
    import flash.utils.IDataOutput;

    public class PacketHelper 
    {

        private static const ZIP_PACKET_SIZE_DELIMITER:int = 2000;
        private static const LONG_SIZE_DELIMITER:int = 0x4000;
        private static const ZIPPED_FLAG:int = 64;
        private static const BIG_LENGTH_FLAG:int = 128;
        private static const HELPER:ByteArray = new ByteArray();


        public static function unwrapPacket(_arg_1:IDataInput, _arg_2:ProtocolBuffer, _arg_3:CompressionType):Boolean
        {
            var _local_4:Boolean;
            var _local_5:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            if (_arg_1.bytesAvailable < 2)
            {
                return (false);
            };
            var _local_6:int = _arg_1.readByte();
            var _local_7:Boolean = (!((_local_6 & BIG_LENGTH_FLAG) == 0));
            if (_local_7)
            {
                if (_arg_1.bytesAvailable >= 3)
                {
                    _local_4 = (!(_arg_3 == CompressionType.NONE));
                    _local_10 = ((_local_6 ^ BIG_LENGTH_FLAG) << 24);
                    _local_11 = ((_arg_1.readByte() & 0xFF) << 16);
                    _local_12 = ((_arg_1.readByte() & 0xFF) << 8);
                    _local_13 = (_arg_1.readByte() & 0xFF);
                    _local_5 = (((_local_10 + _local_11) + _local_12) + _local_13);
                }
                else
                {
                    return (false);
                };
            }
            else
            {
                _local_4 = (!((_local_6 & ZIPPED_FLAG) == 0));
                _local_10 = ((_local_6 & 0x3F) << 8);
                _local_12 = (_arg_1.readByte() & 0xFF);
                _local_5 = (_local_10 + _local_12);
            };
            if (_arg_1.bytesAvailable < _local_5)
            {
                return (false);
            };
            var _local_8:ByteArray = new ByteArray();
            if (_local_5 != 0)
            {
                _arg_1.readBytes(_local_8, 0, _local_5);
            };
            if (_local_4)
            {
                _local_8.uncompress();
            };
            _local_8.position = 0;
            var _local_9:ByteArray = ByteArray(_arg_2.reader);
            OptionalMapCodecHelper.decodeNullMap(_local_8, _arg_2.optionalMap);
            _local_9.writeBytes(_local_8, _local_8.position, (_local_8.length - _local_8.position));
            _local_9.position = 0;
            return (true);
        }

        public static function wrapPacket(_arg_1:IDataOutput, _arg_2:ProtocolBuffer, _arg_3:CompressionType):void
        {
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_4:Boolean;
            switch (_arg_3)
            {
                case CompressionType.NONE:
                    break;
                case CompressionType.DEFLATE:
                    _local_4 = true;
                    break;
                case CompressionType.DEFLATE_AUTO:
                    _local_4 = determineZipped(_arg_2.reader);
                    break;
            };
            HELPER.position = 0;
            HELPER.length = 0;
            OptionalMapCodecHelper.encodeNullMap(_arg_2.optionalMap, HELPER);
            _arg_2.reader.readBytes(HELPER, HELPER.position, _arg_2.reader.bytesAvailable);
            HELPER.position = 0;
            var _local_5:Boolean = isLongSize(HELPER);
            if (_local_4)
            {
                HELPER.compress();
            };
            var _local_6:int = HELPER.length;
            if (_local_5)
            {
                _local_7 = (_local_6 + (BIG_LENGTH_FLAG << 24));
                _arg_1.writeInt(_local_7);
            }
            else
            {
                _local_8 = int((((_local_6 & 0xFF00) >> 8) + ((_local_4) ? ZIPPED_FLAG : 0)));
                _local_9 = int((_local_6 & 0xFF));
                _arg_1.writeByte(_local_8);
                _arg_1.writeByte(_local_9);
            };
            _arg_1.writeBytes(HELPER, 0, _local_6);
        }

        private static function isLongSize(_arg_1:IDataInput):Boolean
        {
            return ((_arg_1.bytesAvailable >= LONG_SIZE_DELIMITER) || (_arg_1.bytesAvailable == -1));
        }

        private static function determineZipped(_arg_1:IDataInput):Boolean
        {
            return ((_arg_1.bytesAvailable == -1) || (_arg_1.bytesAvailable > ZIP_PACKET_SIZE_DELIMITER));
        }

        private static function bytesToString(_arg_1:ByteArray, _arg_2:int, _arg_3:int, _arg_4:int):String
        {
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:String;
            var _local_5:String = "";
            var _local_6:int = _arg_1.position;
            _arg_1.position = _arg_2;
            while (((_arg_1.bytesAvailable > 0) && (_local_9 < _arg_3)))
            {
                _local_9++;
                _local_10 = _arg_1.readUnsignedByte().toString(16);
                if (_local_10.length == 1)
                {
                    _local_10 = ("0" + _local_10);
                };
                _local_5 = (_local_5 + _local_10);
                _local_8++;
                if (_local_8 == 4)
                {
                    _local_8 = 0;
                    _local_7++;
                    if (_local_7 == _arg_4)
                    {
                        _local_7 = 0;
                        _local_5 = (_local_5 + "\n");
                    }
                    else
                    {
                        _local_5 = (_local_5 + "  ");
                    };
                }
                else
                {
                    _local_5 = (_local_5 + " ");
                };
            };
            if (_local_9 < _arg_3)
            {
                _local_5 = (_local_5 + (((("\nOnly " + _local_9) + " of ") + _arg_3) + " bytes have been read"));
            };
            _arg_1.position = _local_6;
            return (_local_5);
        }


    }
}