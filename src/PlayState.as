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
            zero.addResponse("I know.", 2);
            zero.addResponse("That's not fair mom, she's my best friend!", 1);
            zero.addResponse("...", 4);
            convoTree[0] = zero;

            var one:ConvoBranch = new ConvoBranch(1, "All you two do together is eat pizza and ice cream. You're going to gain weight.");
            one.addResponse("I don't know, we go to the library a lot.", 2);
            one.addResponse("Yeah, I like pizza and ice cream.", 3);
            one.addResponse("Sorry.", 2);
            convoTree[1] = one;

            var two:ConvoBranch = new ConvoBranch(2, "Why can't you find a new friend? She's not the only girl on earth.");
            two.addResponse("I don't know...", 6);
            two.addResponse("We have fun together though, and we play outside a lot.", 5);
            two.addResponse("She's really nice to me. I don't need a new friend.", 3);
            convoTree[2] = two;

            var three:ConvoBranch = new ConvoBranch(3, "I'm sure there are other nice girls at school.");
            three.addResponse("People think I'm weird.", 6);
            three.addResponse("I do have other friends at school.", 6);
            three.addResponse("...", 4);
            convoTree[3] = three;

            var four:ConvoBranch = new ConvoBranch(4, "Hello? What's wrong with you?");
            four.addResponse("Nothing. I just like her.", 5);
            four.addResponse("Why do you care? You're being mean.", 5);
            four.addResponse("I don't want to talk about it.", 2);
            convoTree[4] = four;

            var five:ConvoBranch = new ConvoBranch(5, "Liz is fresh. She's always swearing.");
            five.addResponse("I don't care. I like her.", 8);
            five.addResponse("Ok, so?", 8;
            five.addResponse("But Liz is my friend! She's my best friend!", 9);
            convoTree[5] = five;

            var six:ConvoBranch = new ConvoBranch(6, "What about those pretty girls on the tennis team?");
            six.addResponse("They're bullies, mom.", 5);
            six.addResponse("We don't talk much.", 7);
            six.addResponse("I don't like them.", 7);
            convoTree[6] = six;

            var seven:ConvoBranch = new ConvoBranch(7, "Why?");
            seven.addResponse("You just wish I was skinny and pretty like them!", 8);
            seven.addResponse("God mom--I like Liz and I don't like them, ok?", 9);
            convoTree[7] = seven;

            var eight:ConvoBranch = new ConvoBranch(8, "Now YOU'RE being fresh? This is why you can't hang around her anymore!");
            eight.addResponse("YOU'RE SUCH A BITCH!", -1);
            convoTree[8] = eight;

            var nine:ConvoBranch = new ConvoBranch(9, "Well, you're absolutely not allowed to see Liz anymore. No is no.");
            nine.addResponse("YOU'RE SUCH A BITCH!", -1);
            convoTree[9] = nine;

            return convoTree;

        }
    }
}
