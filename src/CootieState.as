package
{
    import org.flixel.*;

    public class CootieState extends TimedState{
        [Embed(source = '../assets/CootieLayer0.png')] public static var spriteBG:Class;
        [Embed(source = '../assets/CootieHand.png')] public static var spriteHand:Class;
        [Embed(source = '../assets/CootieMove.png')] public static var spriteMove:Class;
        [Embed(source = '../assets/CootieCatcher.png')] public static var spriteOpen:Class;
        [Embed(source = '../assets/paper1.mp3')] public static var sndPaper1:Class;
        [Embed(source = '../assets/paper2.mp3')] public static var sndPaper2:Class;
        [Embed(source = '../assets/paper3.mp3')] public static var sndPaper3:Class;
        [Embed(source = '../assets/papercorner.mp3')] public static var sndPaperCorner:Class;

        public var promptText:FlxText;
        private var selector:Selector;
        private var choicePositions:Array;
        private var hand:FlxSprite;
        private var _open:FlxSprite;
        private var curState:int = 0;
        private var curConfig:int = 0;
        private var _endTime:int = -1;
        private var moveStartTime:int = 0;
        private var lastMoveTime:int = 0;
        private var curChoice:int = -1;
        private var gameDone:Boolean = false;

        private static var NO_RESULT:int = -1;

        override public function create():void{
            var bg:FlxSprite = new FlxSprite(0, 0, spriteBG);
            add(bg);
            _open = new FlxSprite(0, 0);
            _open.loadGraphic(spriteOpen, true, true, 616, 600);
            _open.addAnimation("rg", [1]);
            _open.addAnimation("ob", [2]);
            _open.addAnimation("py", [3]);
            _open.addAnimation("pb", [4]);
            _open.addAnimation("wait", [0]);
            hand = new FlxSprite(0, 0);
            hand.loadGraphic(spriteMove, true, true, 320, 240, true);
            hand.addAnimation("move1", [0], 3, false);
            hand.addAnimation("move2", [0, 1], 3, false);
            hand.addAnimation("move3", [0, 1, 0], 3, false);
            hand.addAnimation("move4", [0, 1, 0, 1], 3, false);
            hand.addAnimation("move5", [0, 1, 0, 1, 0], 3, false);
            hand.addAnimation("move6", [0, 1, 0, 1, 0, 1], 3, false);
            hand.addAnimation("amove1", [1], 3, false);
            hand.addAnimation("amove2", [1, 0], 3, false);
            hand.addAnimation("amove3", [1, 0, 1], 3, false);
            hand.addAnimation("amove4", [1, 0, 1, 0], 3, false);
            hand.addAnimation("amove5", [1, 0, 1, 0, 1], 3, false);
            hand.addAnimation("amove6", [1, 0, 1, 0, 1, 0], 3, false);
            hand.addAnimation("still", [2]);
            add(hand);
            hand.play("still");

            promptText = new FlxText(135,10,200,"Wanna play cootie catcher?");
            //add(promptText);

            choicePositions = new Array(
                new FlxPoint(140, 100), new FlxPoint(140, 130),
                new FlxPoint(200, 100), new FlxPoint(200, 130)
            );

            selector = Selector.newFromPoints(choicePositions);
            add(selector);
        }

        public function playPaperSound():void{
            var pick:Number = FlxG.random() * 3;
            if (pick > 2) {
                FlxG.play(sndPaper1, .7);
            } else if (pick > 1) {
                FlxG.play(sndPaper2, .7);
            } else {
                FlxG.play(sndPaper3, .7);
            }
        }

        override public function update():void{
            super.update();
            if (timeSec - endTime >= 5){
                FlxG.switchState(new MallState("...Bye", new EndState("Who was that? A new friend?")));
            }
            if (moveStartTime != 0) {
                if(lastMoveTime == 0){
                    playPaperSound();
                    lastMoveTime = timeFrame;
                } else if (timeFrame - lastMoveTime == 30 && !gameDone) {
                    playPaperSound();
                    lastMoveTime = timeFrame;
                }
                if(timeFrame - moveStartTime >= curChoice*13){
                    moveStartTime = 0;
                    lastMoveTime = 0;
                }
            }
            var choice:int = getChoice();
            if(choice == NO_RESULT){
            } else {
                moveStartTime = timeFrame;
                if (curState == 0) {
                    if (choice == 0) {
                        hand.play("move1");
                        curChoice = 1;
                        curConfig = 0;
                    } else if (choice == 1){
                        hand.play("move3");
                        curChoice = 3;
                        curConfig = 0;
                    } else if (choice == 2) {
                        hand.play("move2");
                        curChoice = 2;
                        curConfig = 1;
                    } else if (choice == 3) {
                        hand.play("move4");
                        curChoice = 4;
                        curConfig = 1;
                    }
                    curState = 1;
                } else if (curState == 1) {
                    if (curConfig == 0){
                        if (choice == 0) {
                            hand.play("amove6");
                            curChoice = 6;
                            curConfig = 1;
                        } else if (choice == 1){
                            hand.play("amove6");
                            curChoice = 6;
                            curConfig = 1;
                        } else if (choice == 2) {
                            hand.play("amove5");
                            curChoice = 5;
                        } else if (choice == 3) {
                            hand.play("amove4");
                            curConfig = 1;
                            curChoice = 4;
                        }
                    } else if (curConfig == 1){
                        if (choice == 0) {
                            hand.play("move4");
                            curChoice = 4;
                            curConfig = 0;
                        } else if (choice == 1){
                            hand.play("move6");
                            curConfig = 0;
                            curChoice = 6;
                        } else if (choice == 2) {
                            hand.play("move3");
                            curChoice = 3;
                        } else if (choice == 3) {
                            hand.play("move5");
                            curChoice = 5;
                        }
                    }
                    curState = 2;
                } else if (curState == 2) {
                    remove(hand);
                    var bgHand:FlxSprite = new FlxSprite(0, 0, spriteHand);
                    add(bgHand);
                    _open.y = -170;
                    add(_open);
                    endTime = timeSec;
                    gameDone = true;
                    if (curConfig == 0) {
                        if (choice == 0) {
                            _open.play("pb");
                        } else if (choice == 1){
                            _open.angle  = 180;
                            _open.x = -300;
                            _open.play("pb");
                        } else if (choice == 2) {
                            _open.play("rg");
                            _open.x = -300;
                        } else if (choice == 3) {
                            _open.angle  = 180;
                            _open.play("rg");
                        }
                    } else if (curConfig == 1) {
                        if (choice == 0) {
                            _open.play("ob");
                            _open.angle = 90;
                            _open.x = -300;
                        } else if (choice == 1){
                            _open.play("py");
                            _open.angle = 90;
                        } else if (choice == 2) {
                            _open.play("ob");
                            _open.angle = -90;
                        } else if (choice == 3) {
                            _open.play("py");
                            _open.angle = -90;
                            _open.x = -300;
                        }
                    }
                }
            }
        }

        private function getChoice():int{
            if (FlxG.keys.justPressed("ENTER") && !gameDone) {
                return selector.getIndex();
            }
            return NO_RESULT;
        }
    }
}
