package
{
    import org.flixel.*;

    public class PlayState extends FlxState{
        [Embed(source = '../assets/backseat.png')] public static var spriteBackseat:Class;
        [Embed(source = '../assets/frontseat.png')] public static var spriteFrontseat:Class;
        [Embed(source = '../assets/dash.png')] public static var spriteDash:Class;
        [Embed(source = '../assets/wheel.png')] public static var spriteWheel:Class;
        [Embed(source = '../assets/hair.png')] public static var spriteHair:Class;
        [Embed(source = '../assets/road.png')] public static var spriteRoad:Class;
        [Embed(source = '../assets/roadlines.png')] public static var spriteRoadLines:Class;

        public var convo:Convo;
        public var convoTree:Array;
        public var selector:Selector;
        public var posX:int = 50;
        public var posY:int = 50;

        public var bgBackSeats:WigglySprite;
        public var bgFrontSeats:WigglySprite;
        public var bgDash:WigglySprite;
        public var bgHair:WigglySprite;
        public var bgWheel:WigglySprite;
        public var bgRoad:FlxSprite;

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

            var roadLines:FlxSprite = new FlxSprite(176, 40);
            roadLines.loadGraphic(spriteRoadLines, true, true, 6, 38, true);
            roadLines.addAnimation("running", [0, 1, 2], .8);
            add(roadLines);
            roadLines.play("running");

            var builtConvo:Array = buildConversation();
            convo = new Convo(builtConvo[0].responses);

            convo.momSays(200,10,builtConvo[0].momSentence);
            convo.newConvo(posX,posY);
            selector = new Selector(posX-5,convo.choicePos);
            add(convo);
            add(selector);
        }

        override public function update():void{
            super.update();
        }

        public function buildConversation():Array{
            convoTree = new Array();

            var zero:ConvoBranch = new ConvoBranch(0, "I don't want you two being friends--the girl is bad news.");
            zero.addResponse("I know.", 1);
            zero.addResponse("That's not fair mom, she's my best friend!", 1);
            zero.addResponse("...", 1);
            convoTree[0] = zero;

            var one:ConvoBranch = new ConvoBranch(1, "All you two do together is eat pizza and ice cream. You're going to gain weight.");
            one.addResponse("I don't know, we go to the library a lot.", 2);
            one.addResponse("Yeah, I like pizza and ice cream.", 2);
            one.addResponse("Sorry.", 2);
            convoTree[1] = one;

            var two:ConvoBranch = new ConvoBranch(1, "part 2");
            two.addResponse("wwwwww", 2);
            two.addResponse("hahahah", 2);
            convoTree[2] = two;

            return convoTree;

        }
    }
}
