package
{
    import org.flixel.*;

    public class GroceryState extends PlayerState{
        [Embed(source = '../assets/Market.png')] public static var spriteBG:Class;
        [Embed(source = '../assets/eggshatter.mp3')] public static var soundEgg:Class;
        [Embed(source = '../assets/freezerloop.mp3')] public static var soundBG:Class;

        public var eggs:Array;
        public var timerText:FlxText;
        public var lost:Boolean = false;
        public var timeLimit:int = 2;
        public var timeLose:int = -1;
        public var timeGrab:int = -1;
        public var soundLock:Boolean = false;

        override public function create():void{
            super._create(true, false);
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
                var egg:Egg = new Egg(-1870, 170);
                add(egg);
                eggs[i] = egg;
            }

            FlxG.playMusic(soundBG);
        }

        override public function update():void{
            super.update();
            FlxG.collide(player, ground, handleGround);

            var i:int;

            if(timeLose != -1 && timeSec - timeLose >= 2) {
                FlxG.switchState(new TextState("Sorry mom...", new EndState("You need to be more careful.\nI'm sending you back to gymnastics to practice your balance.")));
            }

            if(timeSec == 5){
                if(player.holding == true) {
                    timerText.text = "I have to hurry or mom will be so mad!";
                } else {
                    timerText.text = "Mom wants eggs...";
                }
            }

            if(!lost && player.holding && player.isMoving && timeGrab != -1 && timeFrame - timeGrab > 70){
                timeLose = timeSec;
                timerText.text = "";
                lost = true;
                player.no_control = true;
                player.fallen = true;
                if (!soundLock) {
                    soundLock = true;
                    FlxG.play(soundEgg);
                    player.play("falling");
                    for(i = 0; i < eggs.length; i++){
                        if (eggs[i].held) {
                            eggs[i].play("break");
                        }
                    }
                }
            }

            if (player.grabbing) {
                timeGrab = timeFrame;
                for(i = 0; i < eggs.length; i++){
                    player.holding = true;
                    eggs[i].held = true;
                }
            }

            for(i = 0; i < eggs.length; i++){
                if (eggs[i].held == true){
                    eggs[i].x = player.x+5;
                    eggs[i].y = player.y+10;
                }
            }
        }
    }
}
