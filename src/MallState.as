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

    public class MallState extends TimedState {
        [Embed(source = '../assets/MallLayer0.png')] public static var spriteBG:Class;
        [Embed(source = '../assets/MallLayer1.png')] public static var spriteFriend:Class;
        [Embed(source = '../assets/MallLayer2.png')] public static var spriteGirl:Class;
        [Embed(source = '../assets/foodcourtloop.mp3')] public static var sndBG:Class;

        private var prompt:String;
        private var nextState:FlxState;

        public function MallState(prompt:String, nextState:FlxState){
            super();
            this.prompt = prompt;
            this.nextState = nextState;
        }

        override public function create():void
        {
            endTime = 5;

            var bg:FlxSprite = new FlxSprite(0, 0, spriteBG);
            add(bg);
            var friend:FlxSprite = new FlxSprite(20, 80);
            friend.loadGraphic(spriteFriend, true, true, 116, 166, true);
            friend.addAnimation("run", [0, 1], 3, true);
            add(friend);
            friend.play("run");
            var girl:FlxSprite = new FlxSprite(150, 80, spriteGirl);
            add(girl);

            var t:FlxText;
            t = new FlxText(0,20,FlxG.width,prompt);
            t.size = 14;
            t.alignment = "center";
            add(t);

            FlxG.playMusic(sndBG);
        }

        override public function update():void
        {
            super.update();
        }

        override public function endCallback():void {
            FlxG.switchState(this.nextState);
        }
    }
}
