package alternativa.types
{
    public class Binary64 
    {

        public var low:uint;
        internal var internalHigh:uint;

        public function Binary64(_arg_1:uint=0, _arg_2:uint=0)
        {
            this.low = _arg_1;
            this.internalHigh = _arg_2;
        }

        final internal function div(_arg_1:uint):uint
        {
            var _local_2:uint;
            _local_2 = (this.internalHigh % _arg_1);
            var _local_3:uint = (((this.low % _arg_1) + (_local_2 * 6)) % _arg_1);
            this.internalHigh = (this.internalHigh / _arg_1);
            var _local_4:Number = (((_local_2 * Number(4294967296)) + this.low) / _arg_1);
            this.internalHigh = (this.internalHigh + (_local_4 / 4294967296));
            this.low = _local_4;
            return (_local_3);
        }

        final internal function mul(_arg_1:uint):void
        {
            var _local_2:Number = (Number(this.low) * _arg_1);
            this.internalHigh = ((_local_2 / 4294967296) + (Number(this.internalHigh) * _arg_1));
            this.low = _local_2;
        }

        final internal function add(_arg_1:uint):void
        {
            var _local_2:Number = (Number(this.low) + _arg_1);
            this.internalHigh = ((_local_2 / 4294967296) + this.internalHigh);
            this.low = _local_2;
        }

        final internal function bitwiseNot():void
        {
            this.low = (~(this.low));
            this.internalHigh = (~(this.internalHigh));
        }


    }
}