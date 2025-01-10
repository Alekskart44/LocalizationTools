package 
{
    import alternativa.protocol.impl.Protocol;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.MouseEvent;
    import flash.events.SecurityErrorEvent;
	import flash.filters.DropShadowFilter;
    import flash.net.FileFilter;
    import flash.net.FileReference;
    import flash.utils.ByteArray;
    import platform.client.core.general.resourcelocale.Activator;
    import platform.client.core.general.resourcelocale.format.LocalizedFileFormat;

    import flash.filesystem.File;
    import flash.filesystem.FileStream;
    import flash.filesystem.FileMode;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

	/**
	 * ...
	 * @author alekskart
	 */
    public class Main extends Sprite 
    {
        private var protocol:Protocol;
        
        private var localeStruct:LocalizedFileFormat;
        private var fileReference:FileReference;

        public function Main() 
        {
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }

        private function init(e:Event = null):void 
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
            
            protocol = new Protocol();
            new Activator().start(protocol);
            createMenu();
        }

        private function createMenu():void 
        {
            var disassembleButton:TextField = createButton("Decompile localization file", 0xFFFFFF);
        
            disassembleButton.y = stage.stageHeight / 2 + 20;
            disassembleButton.x = stage.stageWidth / 2 - disassembleButton.width / 2;

            addChild(disassembleButton);
            
            disassembleButton.addEventListener(MouseEvent.CLICK, onDisassembleClick);
        }

        private function createButton(label:String, color:uint):TextField 
        {
            var button:TextField = new TextField();
            var textFormat:TextFormat = new TextFormat();
            textFormat.size = 24;
            textFormat.font = "Arial";
            textFormat.color = 0x000000;
            
            button.autoSize = TextFieldAutoSize.CENTER;
            button.text = label;
            button.background = true;
            button.backgroundColor = color;
            button.border = true;
            button.borderColor = 0x000000;
            button.defaultTextFormat = textFormat;
            button.selectable = false;
            button.mouseEnabled = true;
            
            var shadow:DropShadowFilter = new DropShadowFilter();
            shadow.distance = 5;
            shadow.angle = 45;
            shadow.color = 0x000000;
            shadow.alpha = 0.5;
            shadow.blurX = 8;
            shadow.blurY = 8;
            button.filters = [shadow];

            button.width = 300;
            button.height = 60;
			button.scaleX = 1.6;
			button.scaleY = 1.6;

            return button;
        }
	
		private function onDisassembleClick(event:MouseEvent):void 
        {
            fileReference = new FileReference();
            fileReference.addEventListener(Event.SELECT, onFileSelected);
            fileReference.addEventListener(IOErrorEvent.IO_ERROR, onFileLoadError);
            fileReference.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onFileLoadError);
            fileReference.browse([]);
        }
		
        private function onFileSelected(event:Event):void 
        {
            fileReference.addEventListener(Event.COMPLETE, onFileLoadComplete);
            fileReference.load();
        }

        private function onFileLoadComplete(event:Event):void 
        {
            try {
                this.localeStruct = protocol.decode(LocalizedFileFormat, fileReference.data);
                
                if (this.localeStruct && this.localeStruct.strings && this.localeStruct.strings.length > 0) {
                    var jsonString:String = JSON.stringify(this.localeStruct, null, 4);
                    saveToFile(jsonString);
                } 
				
				//No support images localeStruct.images
            } catch (e:Error) {
				MessageWindow.showMessage("Error processing file: " + e.message, this);
            }
        }
		
        private function saveToFile(content:String):void
        {
            var file:File = new File(); 
            file.addEventListener(Event.SELECT, function(event:Event):void {
            var selectedFile:File = event.target as File;

			if (selectedFile.extension != "json") {
                selectedFile = selectedFile.resolvePath(selectedFile.nativePath + ".json");
            }
            
            var fileStream:FileStream = new FileStream();
            try {
                fileStream.open(selectedFile, FileMode.WRITE);
                fileStream.writeUTFBytes(content);
                fileStream.close();
                MessageWindow.showMessage("File saved: " + selectedFile.nativePath, stage);
                } catch (error:Error) {
                    MessageWindow.showMessage("Error saving file: " + error.message, stage);
                }
            });
            file.browseForSave("Save file");
        }

        private function onFileLoadError(event:Event):void
        {
			MessageWindow.showMessage("Error loading file: " + event, this);
        }
    }
}
