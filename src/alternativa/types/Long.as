package alternativa.types
{
    import flash.utils.Dictionary;
    import flash.utils.ByteArray;

    public final class Long 
    {

        private static var longMap:Dictionary = new Dictionary();
        public static const ZERO:Long = getLong(0, 0);

        private var _low:int;
        private var _high:int;

        public function Long(_arg_1:int, _arg_2:int)
        {
            this._high = _arg_1;
            this._low = _arg_2;
        }

        public static function getLong(_arg_1:int, _arg_2:int):Long
        {
            var _local_3:Long;
            var _local_4:Dictionary = longMap[_arg_2];
            if (_local_4 != null)
            {
                _local_3 = _local_4[_arg_1];
                if (_local_3 == null)
                {
                    _local_3 = new Long(_arg_1, _arg_2);
                    _local_4[_arg_1] = _local_3;
                };
            }
            else
            {
                longMap[_arg_2] = new Dictionary();
                _local_3 = new Long(_arg_1, _arg_2);
                longMap[_arg_2][_arg_1] = _local_3;
            };
            return (_local_3);
        }

        public static function fromHexString(_arg_1:String):Long
        {
            var _local_2:int = _arg_1.length;
            if (_local_2 <= 8)
            {
                return (getLong(0, int(("0x" + _arg_1))));
            };
            return (getLong(int(("0x" + _arg_1.substr(0, (_local_2 - 8)))), int(("0x" + _arg_1.substr((_local_2 - 8))))));
        }

        public static function fromInt(_arg_1:int):Long
        {
            if (_arg_1 < 0)
            {
                return (getLong(0xFFFFFFFF, _arg_1));
            };
            return (getLong(0, _arg_1));
        }

        public static function comparator(_arg_1:Long, _arg_2:Long):int
        {
            if (_arg_1 == _arg_2)
            {
                return (0);
            };
            if (_arg_1.high != _arg_2.high)
            {
                return ((_arg_1.high < _arg_2.high) ? -1 : 1);
            };
            if (_arg_1.low != _arg_2.low)
            {
                return ((_arg_1.low < _arg_2.low) ? -1 : 1);
            };
            return (0);
        }


        public function get low():int
        {
            return (this._low);
        }

        public function get high():int
        {
            return (this._high);
        }

        final public function toString(_arg_1:uint=10):String
        {
            var _local_4:uint;
            if (((_arg_1 < 2) || (_arg_1 > 36)))
            {
                throw (new ArgumentError());
            };
            switch (this.high)
            {
                case 0:
                    return (this.low.toString(_arg_1));
                case -1:
                    return (int(this.low).toString(_arg_1));
            };
            if (((this.low == 0) && (this.high == 0)))
            {
                return ("0");
            };
            var _local_2:Array = [];
            var _local_3:UInt64 = new UInt64(this.low, this.high);
            if (this.high < 0)
            {
                _local_3.bitwiseNot();
                _local_3.add(1);
            };
            do 
            {
                _local_4 = _local_3.div(_arg_1);
                _local_2.push((((_local_4 < 10) ? "0" : "a").charCodeAt() + _local_4));
            } while (_local_3.high != 0);
            if (this.high < 0)
            {
                return (("-" + _local_3.low.toString(_arg_1)) + String.fromCharCode.apply(String, _local_2.reverse()));
            };
            return (_local_3.low.toString(_arg_1) + String.fromCharCode.apply(String, _local_2.reverse()));
        }

        public function toByteArray(_arg_1:ByteArray=null):ByteArray
        {
            if (_arg_1 == null)
            {
                _arg_1 = new ByteArray();
            };
            _arg_1.position = 0;
            _arg_1.writeInt(this._high);
            _arg_1.writeInt(this._low);
            _arg_1.position = 0;
            return (_arg_1);
        }


    }
}