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
        public var posX:int = 10;
        public var posY:int = 120;
        public var conversationData:Array;

        public static const CONV_END:Number = -69;
        public static const NO_RESULT:Number = -1;

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

            conversationData = buildConversation();
            convo = new Convo(conversationData[0]);
            convo.newConvo(posX,posY);
            convo.start();
            add(convo);
        }

        override public function update():void{
            super.update();

            var nextSentence:Number = convo.getInput();
            if (nextSentence > 0){
                var piece:ConvoBranch = this.lookupNext(nextSentence);
                convo.kill();
                convo = new Convo(piece);
                convo.newConvo(posX,posY);
                convo.start();
                add(convo);
            } else if (nextSentence == CONV_END) {
                FlxG.switchState(new RoadState());
            }
        }

        public function lookupNext(next:Number):ConvoBranch{
            for (var i:int = 0; i < conversationData.length; i++){
                var cur:ConvoBranch = conversationData[i];
                if (cur._id == next){
                    return cur;
                }
            }
            return null;
        }

        public function buildConversation():Array{
            convoTree = new Array();

            var zero:ConvoBranch = new ConvoBranch(0, "I don't want you two being friends--the girl is bad news.");
            zero.addResponse("I know.", 2);
            zero.addResponse("That's not fair mom, she's my best friend!", 1);
            convoTree[0] = zero;

            var one:ConvoBranch = new ConvoBranch(1, "All you two do together is eat pizza and ice cream. You're going to gain weight.");
            one.addResponse("I don't know, we go to the library a lot.", 2);
            one.addResponse("Yeah, I like pizza and ice cream.", 3);
            one.addResponse("...", 4);
            convoTree[1] = one;

            var two:ConvoBranch = new ConvoBranch(2, "Why can't you find a new friend? She's not the only girl on earth.");
            two.addResponse("...", 4);
            two.addResponse("She's really nice to me. I don't need a new friend.", 3);
            convoTree[2] = two;

            var three:ConvoBranch = new ConvoBranch(3, "I'm sure there are other nice girls at school.");
            three.addResponse("People think I'm weird.", 6);
            three.addResponse("I do have other friends at school.", 13);
            three.addResponse("...", 4);
            convoTree[3] = three;

            var four:ConvoBranch = new ConvoBranch(4, "Hello? What's wrong with you?");
            four.addResponse("Nothing. I just like her.", 5);
            four.addResponse("Why do you care? You're being mean.", 13);
            four.addResponse("Sorry.", 10);
            convoTree[4] = four;

            var five:ConvoBranch = new ConvoBranch(5, "Liz is fresh. She's always swearing.");
            five.addResponse("I don't care. I like her.", 6);
            five.addResponse("Ok, so?", 13);
            five.addResponse("But Liz is my friend! She's my best friend!", 11);
            convoTree[5] = five;

            var six:ConvoBranch = new ConvoBranch(6, "What about those pretty girls on the tennis team?");
            six.addResponse("They're bullies, mom.", 14);
            six.addResponse("We don't talk much.", 7);
            six.addResponse("I don't like them, sorry.", 10);
            convoTree[6] = six;

            var seven:ConvoBranch = new ConvoBranch(7, "Why?");
            seven.addResponse("You just wish I was skinny and pretty like other girls!", 14);
            seven.addResponse("I like Liz, ok? Geez.", 11);
            convoTree[7] = seven;

            var eight:ConvoBranch = new ConvoBranch(8, "Now you're being fresh. This is why you can't hang around her anymore!");
            eight.addResponse("YOU'RE SUCH A BITCH!", CONV_END);
            convoTree[8] = eight;

            var nine:ConvoBranch = new ConvoBranch(9, "Well, you're absolutely not allowed to see Liz anymore. No is no.");
            nine.addResponse("YOU'RE SUCH A BITCH!", CONV_END);
            convoTree[9] = nine;

            var ten:ConvoBranch = new ConvoBranch(10, "Stop apologizing for everything--it's not attractive.");
            ten.addResponse("I don't care if I'm attractive.", 12);
            ten.addResponse("Ok... sorry.", 5);
            ten.addResponse("What do my looks have to do with this?", 11);
            convoTree[10] = ten;

            var eleven:ConvoBranch = new ConvoBranch(11, "Taking care of your body is more important than Liz. Why don't you start running?");
            eleven.addResponse("Friends ARE important. Do you want me to be alone, mom?", 15);
            eleven.addResponse("Liz and I walk everywhere all the time.", 13);
            eleven.addResponse("I don't care about my body.", 12);
            convoTree[11] = eleven;

            var twelve:ConvoBranch = new ConvoBranch(12, "You SHOULD care. Stop letting yourself go!");
            twelve.addResponse("Mom, Liz and I are active. We walk a lot.", 13);
            twelve.addResponse("I think I look fine.", 15);
            twelve.addResponse("I know I'm fat. I suck. Who cares.", 16);
            convoTree[12] = twelve;

            var thirteen:ConvoBranch = new ConvoBranch(13, "I saw that note in your bag. Liz was talking about kissing boys--I don't like that, it's inappropriate.");
            thirteen.addResponse("That's not fair, mom! Stop looking through my backpack!", 16);
            thirteen.addResponse("She's my friend--why do you hate her so much!", 15);
            convoTree[13] = thirteen;

            var fourteen:ConvoBranch = new ConvoBranch(14, "You're just being dramatic.");
            fourteen.addResponse("Other girls tease my friend Alex, they call her fat.", 11);
            fourteen.addResponse("You don't go to my school, so you don't know how much it sucks!", 13);
            convoTree[14] = fourteen;

            var fifteen:ConvoBranch = new ConvoBranch(15, "When you leave middle school you'll make new friends.");
            fifteen.addResponse("How do you know? It's hard to make friends.", 16);
            fifteen.addResponse("No, I won't.", 16);
            convoTree[15] = fifteen;

            var sixteen:ConvoBranch = new ConvoBranch(16, "Stop being so negative and stubborn--girls shouldn't behave like that.");
            sixteen.addResponse("I'm not--why do you always hate my friends!", 9);
            sixteen.addResponse("I don't care what girls are supposed to do!", 8);
            convoTree[16] = sixteen;

            return convoTree;

        }
    }
}
