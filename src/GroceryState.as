package
{
    import org.flixel.*;

    public class GroceryState extends PlayerState{
        [Embed(source = '../assets/Market.png')] public static var spriteBG:Class;
        [Embed(source = '../assets/eggshatter.mp3')] public static var soundEgg:Class;
        [Embed(source = '../assets/freezerloop.mp3')] public static var soundBG:Class;

        public var eggs:Array;
        public var timerText:FlxText;
        public var timeLeft:int = 0;
        public var lost:Boolean = false;
        public var timeLimit:int = 3;
        public var soundLock:Boolean = false;

        override public function create():void{
            super._create(true, true);
            makeGround();

            var bg:FlxSprite = new FlxSprite(0, 0, spriteBG);
            add(bg);

            timerText = new FlxText(50,10,200,"");
            timerText.color = 0xFF666699;
            add(timerText);

            makePlayer();
            player.x = 20;

            eggs = new Array(1);
            for(var i:int = 0; i < eggs.length; i++){
                var egg:Egg = new Egg(70, 210);
                add(egg);
                eggs[i] = egg;
            }

            FlxG.playMusic(soundBG);
        }

        public function loseTimer():void{
            timeLeft++;
            if(timeSec - timeLimit >= 1) {
                FlxG.switchState(new TextState("That was embarassing...", new EndState("")));
            }
        }

        public function endState(player:Player):void{
            if(timeSec == timeLimit-4){
                if(player.holding == true) {
                    if(player.x > FlxG.width - 50){
                        timerText.text = "YOU WIN";
                    } else {
                        timerText.text = "I have to hurry or mom will be so mad!";
                    }
                } else {
                    timerText.text = "Mom wants eggs...";
                }
            }

            if(timeSec == timeLimit){
                timerText.text = "Ow~!";
                lost = true;
                player.no_control = true;
                player.fallen = true;
                if (!soundLock) {
                    soundLock = true;
                    FlxG.play(soundEgg);
                    player.play("falling");
                    for(var i:int = 0; i < eggs.length; i++){
                        if (eggs[i].held) {
                            eggs[i].play("break");
                        }
                    }
                }
            }
        }


        override public function update():void{
            super.update();
            FlxG.collide(player, ground, handleGround);
            endState(player);

            var i:int;

            if (player.grabbing) {
                for(i = 0; i < eggs.length; i++){
                    if (player.overlaps(eggs[i])) {
                        player.holding = true;
                        eggs[i].held = true;
                    }
                }
            }

            for(i = 0; i < eggs.length; i++){
                if (eggs[i].held == true){
                    eggs[i].x = player.x+5;
                    eggs[i].y = player.y+10;
                }
            }

            if(player.holding == true) {
                if (lost) {
                    loseTimer();
                }
                if (FlxG.keys.LEFT){
                    loseTimer();
                } else if(FlxG.keys.RIGHT) {
                    loseTimer();
                }

                if (FlxG.keys.justReleased("RIGHT")) {
                    timeLeft = 0;
                }

                if (FlxG.keys.justReleased("LEFT")) {
                    timeLeft = 0;
                }
            }
        }
    }
}
