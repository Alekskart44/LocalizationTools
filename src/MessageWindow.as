package  {
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.geom.Point;
    import flash.filters.DropShadowFilter;
    import flash.filters.BitmapFilterQuality;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextFormat;
    import flash.text.TextFieldType;
    import flash.text.TextFieldAutoSize;
    import flash.text.AntiAliasType;
    import flash.display.DisplayObject;

    public class MessageWindow extends Sprite {

        private var tfMessage:TextField;
        private var buttonOk:Button;
        private var _currentSize:Point;

        public function MessageWindow() {
            mouseEnabled = false;
            tabEnabled = false;
            this.createMessageField();
            this.createButton();
            this._currentSize = new Point(300, 200);
            this.filters = [new DropShadowFilter(3, 70, 0, 0.5, 2, 2, 1, BitmapFilterQuality.MEDIUM, false, false, false)];
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        }

        public static function showMessage(message:String, parent:DisplayObject):void 
		{
            var window:MessageWindow = new MessageWindow();
            window.text = message;
            parent.stage.addChild(window);
        }

        private function createButton():void {
            this.buttonOk = new Button("Close");
            this.buttonOk.addEventListener(MouseEvent.CLICK, this.onOkButtonClick);
            addChild(this.buttonOk);
        }

        public function hide():void {
            if (parent != null) {
                parent.removeChild(this);
            };
        }

        private function createMessageField():void {
            this.tfMessage = new TextField();
            this.tfMessage.thickness = 50;
            this.tfMessage.sharpness = -50;
            this.tfMessage.width = 250;
            this.tfMessage.y = 25;
            this.tfMessage.defaultTextFormat = new TextFormat("Tahoma", 11, 0);
            this.tfMessage.type = TextFieldType.DYNAMIC;
            this.tfMessage.autoSize = TextFieldAutoSize.CENTER;
            this.tfMessage.antiAliasType = AntiAliasType.ADVANCED;
            this.tfMessage.embedFonts = false;
            this.tfMessage.selectable = true;
            this.tfMessage.multiline = true;
            this.tfMessage.wordWrap = true;
            addChild(this.tfMessage);
        }

        public function set text(message:String):void {
            this.tfMessage.text = message;
            this._currentSize.x = Math.max(Math.round((this.tfMessage.length * 0.5)), 300);
            this.tfMessage.width = (this._currentSize.x - 50);
            this.tfMessage.x = Math.round(((this._currentSize.x - this.tfMessage.textWidth) * 0.5));
            this.repaint();
            this.align();
        }

        public function get currentSize():Point {
            return (this._currentSize);
        }

        private function repaint():void {
            this._currentSize.y = (((25 + this.tfMessage.textHeight) + 30) + this.buttonOk.height);
            this.graphics.clear();
            this.graphics.beginFill(0xCCCCCC, 1);
            this.graphics.drawRoundRect(0, 0, this._currentSize.x, this._currentSize.y, 5, 5);
            this.buttonOk.repaint();
            this.buttonOk.x = Math.round(((this._currentSize.x - this.buttonOk.width) * 0.5));
            this.buttonOk.y = Math.round(((this._currentSize.y - 15) - this.buttonOk.height));
        }

        private function onAddedToStage(_arg_1:Event):void {
            this.repaint();
            this.align();
        }

        private function align():void {
            if (stage != null) {
                x = ((stage.stageWidth - width) >> 1);
                y = ((stage.stageHeight - height) >> 1);
            };
        }

        private function onOkButtonClick(_arg_1:MouseEvent):void {
            this.hide();
        }
    }
}

import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldType;
import flash.text.TextFieldAutoSize;
import flash.text.AntiAliasType;

class Button extends Sprite 
{

    static const H_MARGIN:int = 20;
    static const V_MARGIN:int = 5;

    var tfCaption:TextField;

    public function Button(_arg_1:String)
    {
        this.createCaptionTextField();
        this.caption = _arg_1;
    }

    public function set caption(_arg_1:String):void
    {
        this.tfCaption.text = _arg_1;
        this.repaint();
    }

    public function repaint():void
    {
        if (stage == null)
        {
            return;
        };
        var _local_1:int = (this.tfCaption.textWidth + (2 * H_MARGIN));
        var _local_2:int = (this.tfCaption.textHeight + (2 * V_MARGIN));
        this.tfCaption.x = ((_local_1 - this.tfCaption.textWidth) >> 1);
        this.tfCaption.y = ((_local_2 - this.tfCaption.textHeight) >> 1);
        graphics.beginFill(0xFFFFFF, 1);
        graphics.lineStyle(0, 0x666666);
        graphics.drawRoundRect(0, 0, _local_1, _local_2, 5, 5);
    }

    function createCaptionTextField():void
    {
        this.tfCaption = new TextField();
        this.tfCaption.thickness = 50;
        this.tfCaption.sharpness = -50;
        this.tfCaption.defaultTextFormat = new TextFormat("Tahoma", 12, 0, true);
        this.tfCaption.type = TextFieldType.DYNAMIC;
        this.tfCaption.autoSize = TextFieldAutoSize.LEFT;
        this.tfCaption.antiAliasType = AntiAliasType.ADVANCED;
        this.tfCaption.embedFonts = false;
        this.tfCaption.selectable = false;
        this.tfCaption.multiline = false;
        this.tfCaption.mouseEnabled = false;
        this.tfCaption.tabEnabled = false;
        addChild(this.tfCaption);
    }


}