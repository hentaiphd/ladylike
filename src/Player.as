/*
    This file is part of Ladylike's source.

    Ladylike's source is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Ladylike's source is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with Ladylike's source. If not, see <http://www.gnu.org/licenses/>.
*/

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
        public var fallen:Boolean = false;
        public var isMoving:Boolean = false;
        public var runFast:Boolean = false;
        public var dropping:Boolean = false;

        public function Player(x:int,y:int,slippery:Boolean,grabDown:Boolean):void{
            super(x,y);
            this.slippery = slippery;
            this.grabDown = grabDown;
            loadGraphic(ImgPlayer, true, true, 34, 36, true);
            frameWidth = 34;
            frameHeight = 36;
            width = 10;

            addAnimation("run", [5,6,7,8], 8, true);
            addAnimation("fastrun", [9,10,11,12,13], 8, true);
            addAnimation("standing", [0]);
            addAnimation("crouching", [1, 2], 7, false);
            addAnimation("reaching", [17, 18], 7, false);
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
                dropping = true;
                play("crouching");
            } else if(FlxG.keys.UP && !this.grabDown){
                grabbing = true;
                play("reaching");
            } else {
                if(FlxG.keys.LEFT) {
                    isMoving = true;
                    this.runLeft();
                } else if(FlxG.keys.RIGHT){
                    isMoving = true;
                    this.runRight();
                } else {
                    isMoving = false;
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
            if(this.runFast) {
                play("fastrun");
            } else {
                play("run");
            }
        }

        public function runRight():void{
            facing = RIGHT;
            if (this.slippery){
                drag.x += runSpeed;
                acceleration.x += 60;
            } else {
                x += runSpeed;
            }
            if(this.runFast) {
                play("fastrun");
            } else {
                play("run");
            }
        }

        public function decelerate():void{
            if (counter < 5) {;
                drag.x += 200;
                if (!this.fallen){
                    isMoving = true;
                    if(this.runFast) {
                        play("fastrun");
                    } else {
                        play("run");
                    }
                }
                counter++;
            } else if (counter == 5) {
                if (!this.fallen){
                    isMoving = false;
                    play("standing");
                }
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
