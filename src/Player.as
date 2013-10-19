package
{
    import org.flixel.*;

    public class Player extends FlxSprite{
        [Embed(source="../assets/girl_sprites.png")] private var ImgPlayer:Class;
        private var runSpeed:int = 2;
        public var grabbing:Boolean = false;
        private var _jumppower:int = 290;
        private var jumping:Boolean = false;
        private var running:Boolean = false;
        public var holding:Boolean = false;
        public var counter:int = 0;

        public function Player(x:int,y:int):void{
            super(x,y);
            loadGraphic(ImgPlayer, true, true, 24, 40, true);
            frameWidth = 24;
            frameHeight = 40;
            width = 10;

            addAnimation("run", [7,8,9,10], 8, true);
            addAnimation("standing", [11]);
            addAnimation("crouching", [3]);
        }

        override public function update():void{
            super.update();
            borderCollide();

            acceleration.x = 0;
            drag.x = 200;

            grabbing = false;
            if(FlxG.keys.DOWN){
                grabbing = true;
                play("crouching");
            } else {
                if(FlxG.keys.LEFT) {
                    facing = LEFT;
                    drag.x += runSpeed;
                    acceleration.x -= 60;
                    play("run");
                } else if(FlxG.keys.RIGHT){
                    facing = RIGHT;
                    drag.x += runSpeed;
                    acceleration.x += 60;
                    play("run");
                } else {
                    play("standing");
                    running = false;
                }
            }

            if (FlxG.keys.justReleased("RIGHT")) {
                decelerate();
            }

            if (FlxG.keys.justReleased("LEFT")) {
                decelerate();
            }
        }

        public function decelerate():void{
            if (counter < 5) {;
                drag.x += 100;
                play("run");
                counter++;
            } else if (counter == 5) {
                play("standing");
                counter = 0;
            }
        }

        public function borderCollide():void{
            if(x >= FlxG.width - width)
                x = FlxG.width - width;
            if(this.x <= 0)
                this.x = 0;
            if(this.y >= FlxG.height - height)
                this.y = FlxG.height - height;
            if(this.y <= 0)
                this.y = 0;
        }
    }
}
