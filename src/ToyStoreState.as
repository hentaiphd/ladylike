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

package {
    import org.flixel.*;

    public class ToyStoreState extends PlayerState {
        [Embed(source = '../assets/toyaisle.png')] public static var spriteBG:Class;
        [Embed(source = '../assets/doll.png')] public static var spriteDoll:Class;
        [Embed(source = '../assets/dollnaked.png')] public static var spriteDollNaked:Class;
        [Embed(source = '../assets/toystoreloop.mp3')] public static var sndBG:Class;

        public var toys:Array = new Array();
        public var bg:FlxSprite;
        public var grabTime:int = -1;
        public var nudeTime:int = -1;
        public var doll:FlxSprite;
        public var help:FlxText;
        public var reaching:FlxText;
        public var smoke:FlxSprite;
        public var instruction:FlxSprite;
        public var isFirstGrab:Boolean;

        override public function create():void {
            super._create(false, false);
            makeGround();
            isFirstGrab = true;

            bg = new FlxSprite(0, 0);
            bg.loadGraphic(spriteBG, true, true, 320, 240, true);
            bg.addAnimation("run", [0, 1], 1, false);
            add(bg);

            doll = new FlxSprite(100, 20);
            doll.loadGraphic(spriteDoll, true, true, 845/8, 200);
            doll.addAnimation("fwd", [0, 1, 2, 3, 4, 5, 6, 7, 0], 4, false);
            doll.addAnimation("rev", [7, 6, 5, 4, 3, 2, 1, 0], 4, false);

            makePlayer();
            FlxG.playMusic(sndBG);
            help = new FlxText(40,30,250,"Arrows to walk or grab");
            add(help);
        }

        override public function update():void {
            super.update();

            if (player.grabbing) {
                player.grabbing = false;
                remove(help);
                grabTime = timeSec;
                player.no_control = true;
                smoke = new FlxSprite(0, 0);
                smoke.makeGraphic(320, 240, 0x88000000);
                add(smoke);
                instruction = new FlxText(5,170,100,"LEFT + RIGHT to turn, ENTER to examine further, DOWN to put away.");
                add(instruction);
                add(doll);
                if(isFirstGrab == true){
                    bg.play("run");
                    isFirstGrab = false;
                }
            }

            if (grabTime != -1) {
                if(FlxG.keys.justPressed("LEFT")) {
                    doll.play("fwd");
                } else if (FlxG.keys.justPressed("RIGHT")){
                    doll.play("rev");
                } else if (FlxG.keys.justPressed("ENTER")){
                    doll.loadGraphic(spriteDollNaked, true, true, 845/8, 200, true);
                    nudeTime = timeSec;
                } else if (FlxG.keys.justPressed("DOWN")){
                    FlxG.state.remove(instruction);
                    FlxG.state.remove(smoke);
                    FlxG.state.remove(doll);
                    reaching = new FlxText(40,30,250,"I can't reach those other toys...");
                    add(reaching);
                    player.no_control = false;
                    grabTime = -1;
                }
            }

            if (nudeTime != -1){
                if (timeSec - nudeTime >= 10){
                    FlxG.switchState(new TextState("I wish you would stop cutting the hair off your Barbies. They're so expensive.", new EndState("Why don't you want Baywatch Barbie? She's the prettiest.")));
                }
            }
        }

    }
}
