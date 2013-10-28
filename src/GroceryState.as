package
{
    import org.flixel.*;

    public class GroceryState extends PlayerState{
        [Embed(source = '../assets/field.png')] public static var spriteBG:Class;

        public var eggs:Array;
        public var timerText:FlxText;
        public var timeLeft:int = 0;
        public var lose:Boolean = false;

        override public function create():void{
            super._create(true, true);
            makeGround();

            var bg:FlxSprite = new FlxSprite(0, 0, spriteBG);
            add(bg);

            timerText = new FlxText(135,10,200,timeSec.toString());
            add(timerText);

            makePlayer();

            eggs = new Array(10);
            for(var i:int = 0; i < eggs.length; i++){
                var egg:Egg = new Egg((30*i+Math.random()*40), 210);
                add(egg);
                eggs[i] = egg;
            }
        }

        public function loseTimer():void{
            timeLeft++;
            if(timeLeft%125 == 0) {
                timerText.text = "YOU LOSE";
                this.kill();
            }
        }

        public function endState(player:Player):void{
            if(timeSec == 12-4){
                if(player.holding == true) {
                    if(player.x > FlxG.width - 50){
                        timerText.text = "YOU WIN";
                        lose = true;
                    } else {
                        timerText.text = "I have to hurry or mom will be so mad!";
                        lose = true;
                    }
                } else {
                    timerText.text = "Mom wants eggs...";
                    lose = true;
                }
            }

            if(timeSec == 12){
                timerText.text = "LOSE";
                lose = true;
            }
        }


        override public function update():void{
            super.update();
            FlxG.collide(player, ground, handleGround);
            endState(player);

            if(lose == false){
                timerText.text = timeSec.toString();
            }

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
                    eggs[i].y = player.y-10;
                }
            }

            if(player.holding == true) {
                if (FlxG.keys.LEFT) {
                    loseTimer();
                } else if (FlxG.keys.RIGHT) {
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
