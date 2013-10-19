package
{
    import org.flixel.*;
    import org.twine.*;
    import com.adobe.serialization.json.JSON;
    import flash.debugger.enterDebugger;

    public class PlayState extends FlxState{
        [Embed(source = '../assets/car.png')] public static var spriteCar:Class;
        [Embed(source = '../assets/backseat.png')] public static var spriteBackseat:Class;
        [Embed(source = '../assets/frontseat.png')] public static var spriteFrontseat:Class;
        [Embed(source = '../assets/dash.png')] public static var spriteDash:Class;
        [Embed(source = '../assets/wheel.png')] public static var spriteWheel:Class;
        [Embed(source = '../assets/hair.png')] public static var spriteHair:Class;
        [Embed(source = '../assets/road.png')] public static var spriteRoad:Class;
        [Embed(source = '../assets/roadlines.png')] public static var spriteRoadLines:Class;
        [Embed(source = '../assets/roomtone_lofi.mp3')] public static var sndBG:Class;
        [Embed(source = '../assets/bliphigh.mp3')] public static var sndHiBlip:Class;
        [Embed(source='../assets/ladylike.json', mimeType="application/octet-stream")] public static var twineFile:Class;

        public var convo:Convo;
        public var convoTree:Array;
        public var posX:int = 162;
        public var posY:int = 113;
        public var conversationData:Array;

        public static const CONV_END:Number = -69;
        public static const NO_RESULT:String = "-1";
        public static const RESTART:String = "-42";
        public static const momTextX:int = 25;
        public static const momTextY:int = 117;
        public static const girlTextX:int = 25;
        public static const girlTextY:int = 125;

        public var bgBackSeats:WigglySprite;
        public var bgFrontSeats:WigglySprite;
        public var bgDash:WigglySprite;
        public var bgHair:WigglySprite;
        public var bgWheel:WigglySprite;
        public var bgRoad:FlxSprite;
        public var textBoxMom:FlxSprite;
        public var textBoxReply:FlxSprite;

        override public function create():void{
            bgRoad = new FlxSprite(0, 0, spriteRoad);
            add(bgRoad);
            bgDash = new WigglySprite(0, 0, spriteDash);
            add(bgDash);
            bgWheel = new WigglySprite(0, 0, spriteWheel);
            add(bgWheel);
            bgHair = new WigglySprite(0, 0, spriteHair);
            add(bgHair);
            bgFrontSeats = new WigglySprite(0, 0, spriteFrontseat);
            add(bgFrontSeats);
            bgBackSeats = new WigglySprite(0, 0, spriteBackseat);
            add(bgBackSeats);

           if(FlxG.music == null){
                FlxG.playMusic(sndBG);
            } else {
                FlxG.music.resume();
                if(!FlxG.music.active){
                    FlxG.playMusic(sndBG);
                }
            }

            var roadLines:FlxSprite = new FlxSprite(176, 40);
            roadLines.loadGraphic(spriteRoadLines, true, true, 6, 38, true);
            roadLines.addAnimation("running", [0, 1, 2], .8);
            add(roadLines);
            roadLines.play("running");

            textBoxReply = new FlxSprite(girlTextX,girlTextY);
            textBoxReply.makeGraphic(160,90,0x88999999);
            add(textBoxReply);

            textBoxMom = new FlxSprite(momTextX,momTextY);
            textBoxMom.makeGraphic(140,57,0x88999999);
            add(textBoxMom);

            var pages:Array = (new org.twine.TwineImporter(twineFile)).getPages();

            conversationData = buildConversation(pages);
            var start_branch:ConvoBranch;
            for(var i:Number = 0; i < conversationData.length; i++){
                if(conversationData[i]._id == "Start") {
                    start_branch = conversationData[i];
                }
            }

            var testBG:FlxSprite = new FlxSprite(0,0);
            testBG.loadGraphic(spriteCar, true, true, 320, 240, true);
            add(testBG);

            convo = new Convo(start_branch);
            convo.newConvo(girlTextX,girlTextY);
            convo.start();
        }

        override public function update():void{
            super.update();

            var nextSentence:String = convo.getInput();
            if (int(nextSentence) > 0){
                FlxG.play(sndHiBlip);
                var piece:ConvoBranch = this.lookupNext(nextSentence);
                convo.kill();
                convo = new Convo(piece);
                convo.newConvo(girlTextX,girlTextY);
                convo.start();
            } else if (nextSentence == "CONVO_END") {
                FlxG.music.stop();
                FlxG.switchState(new DoorState());
            } else if (nextSentence == "RESTART") {
                FlxG.switchState(new PlayState());
            }
        }

        public function lookupNext(next:String):ConvoBranch{
            for (var i:int = 0; i < conversationData.length; i++){
                var cur:ConvoBranch = conversationData[i];
                if (cur._id == next){
                    return cur;
                }
            }
            return null;
        }

        public function buildConversation(pages:Array):Array{
            convoTree = new Array();
            for (var i:Number = 0; i < pages.length; i++) {
                var momText:String = pages[i].getLine(0);
                var cur:ConvoBranch = new ConvoBranch(pages[i].getTitle(), momText);
                for (var j:Number = 1; j < pages[i].getNumberOfLines(); j++) {
                    if(pages[i].getLine(j) != "") {
                        var regex:RegExp = /[\[\[\]\]]/g;
                        var stripped:Array = pages[i].getLine(j).replace(regex, "").split("|");
                        var response:String = stripped[0];
                        var targ:String = stripped[1];
                        cur.addResponse(response, targ);
                    }
                }
                convoTree[i] = cur;
            }
            return convoTree;
        }
    }
}
