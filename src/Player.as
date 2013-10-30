package
{
    import org.flixel.*;

    public class Player extends FlxSprite{
        [Embed(source="../assets/girl_sprites_new.png")] private var ImgPlayer:Class;

        private var runSpeed:int = 2;
        public var grabbing:Boolean = false;
        private var _jumppower:int = 290;
        private var jumping:Boolean = false;
        private var running:Boolean = false;
        public var holding:Boolean = false;
        public var counter:int = 0;
        private var slippery:Boolean = false;
        private var grabDown:Boolean = false;
        public var no_control:Boolean = false;

        public function Player(x:int,y:int,slippery:Boolean,grabDown:Boolean):void{
            super(x,y);
            this.slippery = slippery;
            this.grabDown = grabDown;
            loadGraphic(ImgPlayer, true, true, 34, 36, true);
            frameWidth = 34;
            frameHeight = 36;
            width = 10;

            addAnimation("run", [7,8,9,10], 8, true);
            addAnimation("standing", [0]);
            addAnimation("crouching", [1, 2], 7, false);
            addAnimation("falling", [14, 15, 16], 7, false);

            if (!this.slippery) {
                drag.x = runSpeed*8;
                drag.y = runSpeed*3;
            }
        }

        override public function update():void{
            super.update();
            borderCollide();

            acceleration.x = 0;
            if (!this.slippery) {
                acceleration.y = 1000;
            } else {
                drag.x = 200;
            }

            grabbing = false;
            if (this.slippery) {
                if (FlxG.keys.justReleased("RIGHT")) {
                    decelerate();
                }
                if (FlxG.keys.justReleased("LEFT")) {
                    decelerate();
                }
            }

            if (this.no_control) return;
            if(FlxG.keys.DOWN && this.grabDown){
                grabbing = true;
                play("crouching");
            } else if(FlxG.keys.UP && !this.grabDown){
                grabbing = true;
                play("crouching");
            } else {
                if(FlxG.keys.LEFT) {
                    this.runLeft();
                } else if(FlxG.keys.RIGHT){
                    this.runRight();
                } else {
                    play("standing");
                    running = false;
                }
            }

        }

        public function runLeft():void{
            facing = LEFT;
            if (this.slippery){
                drag.x += runSpeed;
                acceleration.x -= 60;
            } else {
                x -= runSpeed;
            }
            play("run");
        }

        public function runRight():void{
            facing = RIGHT;
            if (this.slippery){
                drag.x += runSpeed;
                acceleration.x += 60;
            } else {
                x += runSpeed;
            }
            play("run");
        }

        public function decelerate():void{
            if (counter < 5) {;
                drag.x += 200;
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
