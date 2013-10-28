package
{
    import org.flixel.*;

    public class CootieState extends FlxState{
        [Embed(source = '../assets/CootieLayer0.png')] public static var spriteBG:Class;
        [Embed(source = '../assets/CootieHand.png')] public static var spriteHand:Class;
        [Embed(source = '../assets/CootieMove.png')] public static var spriteMove:Class;
        [Embed(source = '../assets/CootieCatcher.png')] public static var spriteOpen:Class;

        public var promptText:FlxText;
        private var selector:Selector;
        private var choicePositions:Array;
        private var hand:FlxSprite;
        private var _open:FlxSprite;
        private var curState:int = 0;
        private var curConfig:int = 0;

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

            promptText = new FlxText(135,10,200,"Let's play cootie catcher");
            //add(promptText);

            choicePositions = new Array(
                new FlxPoint(140, 100), new FlxPoint(140, 130),
                new FlxPoint(200, 100), new FlxPoint(200, 130)
            );

            selector = Selector.newFromPoints(choicePositions);
            add(selector);
        }

        override public function update():void{
            super.update();
            var choice:int = getChoice();
            if(choice == NO_RESULT){

            } else {
                if (curState == 0) {
                    if (choice == 0) {
                        hand.play("move1");
                        curConfig = 0;
                    } else if (choice == 1){
                        hand.play("move3");
                        curConfig = 0;
                    } else if (choice == 2) {
                        hand.play("move2");
                        curConfig = 1;
                    } else if (choice == 3) {
                        hand.play("move4");
                        curConfig = 1;
                    }
                    curState = 1;
                } else if (curState == 1) {
                    if (curConfig == 0){
                        if (choice == 0) {
                            hand.play("amove6");
                            curConfig = 1;
                        } else if (choice == 1){
                            hand.play("amove6");
                            curConfig = 1;
                        } else if (choice == 2) {
                            hand.play("amove5");
                        } else if (choice == 3) {
                            hand.play("amove4");
                            curConfig = 1;
                        }
                    } else if (curConfig == 1){
                        if (choice == 0) {
                            hand.play("move4");
                            curConfig = 0;
                        } else if (choice == 1){
                            hand.play("move6");
                            curConfig = 0;
                        } else if (choice == 2) {
                            hand.play("move3");
                        } else if (choice == 3) {
                            hand.play("move5");
                        }
                    }
                    curState = 2;
                } else if (curState == 2) {
                    remove(hand);
                    var bgHand:FlxSprite = new FlxSprite(0, 0, spriteHand);
                    add(bgHand);
                    _open.y = -190;
                    add(_open);
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
            if (FlxG.keys.justPressed("ENTER")) {
                return selector.getIndex();
            }
            return NO_RESULT;
        }
    }
}
