package
{
    import org.flixel.*;

    public class Player extends FlxSprite{
        [Embed(source="../assets/girl_sprites.png")] private var ImgPlayer:Class;
        private var runSpeed:int = 5;
        private var _jumppower:int = 290;
        private var jumping:Boolean = false;
        private var running:Boolean = false;

        public function Player(x:int,y:int):void{
            super(x,y);
            loadGraphic(ImgPlayer, true, true, 48, 80, true);
            frameWidth = 48;
            frameHeight = 80;
            width = 20

            addAnimation("run", [7,8,9,10], 14, true);
            addAnimation("standing", [11]);
            addAnimation("crouching", [3]);
            addAnimation("jumping", [4]);
            addAnimation("apex", [5]);
            addAnimation("falling", [6]);
            addAnimation("fishslap", [1,2], 14, false);

            drag.x = runSpeed*8;
            drag.y = runSpeed*3;
        }

        override public function update():void{
            super.update();
            borderCollide();
            acceleration.x = 0;
            acceleration.y = 1000;


            if(FlxG.keys.LEFT) {
                facing = LEFT;
                x -= runSpeed;
                play("run");
            } else if(FlxG.keys.RIGHT){
                facing = RIGHT;
                x += runSpeed;
                play("run");
            } else {
                play("standing");
                running = false;
            }

            if(this.isTouching(FlxObject.FLOOR)){
                jumping = false;
            }

            if((FlxG.keys.SPACE || FlxG.keys.UP)){
                if(!jumping){
                    play("crouching");
                    jumping = true;
                    velocity.y -= _jumppower;
                } else {
                    velocity.y -= 10;
                }
            }

            if(jumping == true){
                if(velocity.y < 0){
                    play("jumping");
                }
                if(velocity.y > 0){
                    play("falling");
                }
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