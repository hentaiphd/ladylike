package
{
    import org.flixel.*;

    public class PlayState extends FlxState{
        [Embed(source = '../assets/backseat.png')] public static var spriteBackseat:Class;
        [Embed(source = '../assets/frontseat.png')] public static var spriteFrontseat:Class;
        [Embed(source = '../assets/dash.png')] public static var spriteDash:Class;
        public var convo:Convo;
        public var convoTree:Array;
        public var selector:Selector;
        public var posX:int = 50;
        public var posY:int = 50;

        public var bgBackSeats:WigglySprite;
        public var bgFrontSeats:WigglySprite;
        public var bgDash:WigglySprite;
        public var bgRoad:WigglySprite;

        override public function create():void{
            bgDash = new WigglySprite(0, 0, spriteDash);
            add(bgDash);
            bgFrontSeats = new WigglySprite(0, 0, spriteFrontseat);
            add(bgFrontSeats);
            bgBackSeats = new WigglySprite(0, 0, spriteBackseat);
            add(bgBackSeats);


            convo = new Convo();

            convo.momSays(200,10,"WTF Nina");
            convo.newConvo("onee","twooooooo","threeeeeeeeeee",posX,posY);
            selector = new Selector(posX-5,convo.choicePos);
            add(convo);
            add(selector);
        }

        override public function update():void{

        }

        public function buildConversation():void{
            convoTree = new Array();

            var zero:ConvoBranch = new ConvoBranch(0, "I'm mom");
            zero.addResponse("i know", 1);
            zero.addResponse("yup", 1);
            //convoTree.[0] = zero;

            var one:ConvoBranch = new ConvoBranch(1, "part 2");
            one.addResponse("i know", 2);
            one.addResponse("yup", 2);
            //convoTree.[1] = one;


        }
    }
}
