package
{
    import org.flixel.*;
    import org.twine.*;
    import com.adobe.serialization.json.JSON;

    public class PlayState extends TimedState{
        [Embed(source = '../assets/CarLayer2.png')] public static var spriteFrontseat:Class;
        [Embed(source = '../assets/CarLayer1.png')] public static var spriteDash:Class;
        [Embed(source = '../assets/CarLayer0.png')] public static var spriteRoad:Class;
        [Embed(source = '../assets/GirlFidget.png')] public static var spriteGirl:Class;
        [Embed(source = '../assets/GirlSpeech.png')] public static var spriteGirlSpeech:Class;
        [Embed(source = '../assets/MomSpeech.png')] public static var spriteMomSpeech:Class;
        [Embed(source = '../assets/roomtone_lofi.mp3')] public static var sndBG:Class;
        [Embed(source = '../assets/bliphigh.mp3')] public static var sndHiBlip:Class;
        [Embed(source='../assets/ladylike.json', mimeType="application/octet-stream")] public static var twineFile:Class;

        public var convo:Convo;
        public var convoTree:Array;
        public var posX:int = 162;
        public var posY:int = 113;
        public var conversationData:Array;
        public var started:Boolean = false;

        public static const CONV_END:Number = -69;
        public static const NO_RESULT:String = "-1";
        public static const RESTART:String = "-42";
        public static const momTextX:int = 17;
        public static const momTextY:int = 117;
        public static const girlTextX:int = 15;
        public static const girlTextY:int = 135;

        public var bgFrontSeats:WigglySprite;
        public var bgDash:WigglySprite;
        public var bgRoad:FlxSprite;
        public var girl:FlxSprite;
        public var textBoxMom:FlxSprite;
        public var textBoxReply:FlxSprite;

        override public function create():void{
            bgRoad = new FlxSprite(-20, 0);
            bgRoad.loadGraphic(spriteRoad, true, true, 360, 240, true);
            bgRoad.addAnimation("run", [0, 1, 2, 3], 6, true);
            add(bgRoad);
            bgRoad.play("run");
            bgDash = new WigglySprite(-25, 0, spriteDash);
            add(bgDash);
            bgFrontSeats = new WigglySprite(-25, 0, spriteFrontseat);
            add(bgFrontSeats);
            girl = new WigglySprite(244, 190);
            girl.loadGraphic(spriteGirl, true, true, 78, 54, true);
            girl.addAnimation("run", [0, 1, 2], 2, true);
            add(girl);
            girl.play("run");

            FlxG.playMusic(sndBG);
        }

        override public function update():void{
            super.update();

            if (timeSec == 2 && !started){
                started = true;
                var girlSpeech:FlxSprite = new FlxSprite(220, 225, spriteGirlSpeech);
                add(girlSpeech);
                var momSpeech:FlxSprite = new FlxSprite(30, 80, spriteMomSpeech);
                add(momSpeech);

                textBoxReply = new FlxSprite(girlTextX-8,girlTextY);
                textBoxReply.makeGraphic(240,90,0x99FFFFFF);
                add(textBoxReply);

                textBoxMom = new FlxSprite(momTextX-5,momTextY);
                textBoxMom.makeGraphic(225,37,0xFF000000);
                add(textBoxMom);

                var pages:Array = (new org.twine.TwineImporter(twineFile)).getPages();

                conversationData = buildConversation(pages);
                var start_branch:ConvoBranch;
                for(var i:Number = 0; i < conversationData.length; i++){
                    if(conversationData[i]._id == "Start") {
                        start_branch = conversationData[i];
                    }
                }

                convo = new Convo(start_branch);
                convo.newConvo(girlTextX,girlTextY);
                convo.start();
            }

            if (!started) { return; }

            var nextSentence:String = convo.getInput();
            if (int(nextSentence) > 0){
                FlxG.play(sndHiBlip);
                var piece:ConvoBranch = this.lookupNext(nextSentence);
                convo.kill();
                convo = new Convo(piece);
                convo.newConvo(girlTextX,girlTextY);
                convo.start();
            } else if (nextSentence == "ANGRY_END") {
                FlxG.music.stop();
                FlxG.switchState(new TextState("GET OUT OF THE CAR", new RoadState()));
            } else if(nextSentence == "RAND_END") {
                FlxG.music.stop();
                var pick:Number = FlxG.random()*5;
                if (pick > 3) {
                    FlxG.switchState(new TextState("Wait for me in\nthe food court.", new MallState("Hey, wanna play cootie catcher?", new CootieState())));
                } else if (pick > 2){
                    FlxG.switchState(new TextState("Pick out some clothes.", new DressingState()))
                } else if (pick > 1) {
                    FlxG.switchState(new TextState("Let's check out now.", new CheckoutState("Run and grab some eggs, would you?", new GroceryState())));
                } else {
                    FlxG.switchState(new TextState("I'm shopping--you can wait\nin the toystore.", new ToyStoreState()));
                }
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
