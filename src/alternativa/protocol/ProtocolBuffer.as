package alternativa.protocol
{
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import flash.utils.ByteArray;

    public class ProtocolBuffer 
    {

        private var _writer:IDataOutput;
        private var _reader:IDataInput;
        private var _optionalMap:OptionalMap;

        public function ProtocolBuffer(_arg_1:IDataOutput, _arg_2:IDataInput, _arg_3:OptionalMap)
        {
            this._writer = _arg_1;
            this._reader = _arg_2;
            this._optionalMap = _arg_3;
        }

        public function get writer():IDataOutput
        {
            return (this._writer);
        }

        public function set writer(_arg_1:IDataOutput):void
        {
            this._writer = _arg_1;
        }

        public function get reader():IDataInput
        {
            return (this._reader);
        }

        public function set reader(_arg_1:IDataInput):void
        {
            this._reader = _arg_1;
        }

        public function get optionalMap():OptionalMap
        {
            return (this._optionalMap);
        }

        public function set optionalMap(_arg_1:OptionalMap):void
        {
            this._optionalMap = _arg_1;
        }

        public function toString():String
        {
            var _local_6:int;
            var _local_7:String;
            var _local_1:String = "";
            var _local_2:int = ByteArray(this.reader).position;
            _local_1 = (_local_1 + "\n=== Optional Map ===\n");
            _local_1 = (_local_1 + this.optionalMap.toString());
            _local_1 = (_local_1 + "\n=== Dump data (trunc 100 bytes) ===\n");
            var _local_3:int;
            var _local_4:String = "";
            var _local_5:int;
            while (((ByteArray(this.reader).bytesAvailable) && (_local_5 < 100)))
            {
                _local_6 = this.reader.readByte();
                _local_7 = String.fromCharCode(_local_6);
                if (((_local_6 >= 0) && (_local_6 < 16)))
                {
                    _local_1 = (_local_1 + "0");
                };
                if (_local_6 < 0)
                {
                    _local_6 = (0x0100 + _local_6);
                };
                _local_1 = (_local_1 + _local_6.toString(16));
                _local_1 = (_local_1 + " ");
                if (((_local_6 < 12) && (_local_6 > 128)))
                {
                    _local_4 = (_local_4 + ".");
                }
                else
                {
                    _local_4 = (_local_4 + _local_7);
                };
                _local_3++;
                if (_local_3 > 16)
                {
                    _local_1 = (_local_1 + "\t");
                    _local_1 = (_local_1 + _local_4);
                    _local_1 = (_local_1 + "\n");
                    _local_3 = 0;
                    _local_4 = "";
                };
                _local_5++;
            };
            if (_local_3 != 0)
            {
                while (_local_3 < 18)
                {
                    _local_3++;
                    _local_1 = (_local_1 + "   ");
                };
                _local_1 = (_local_1 + "\t");
                _local_1 = (_local_1 + _local_4);
                _local_1 = (_local_1 + "\n");
            };
            ByteArray(this.reader).position = _local_2;
            return (_local_1);
        }


    }
}