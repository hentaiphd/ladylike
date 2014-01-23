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

    public class CheckoutState extends TimedState {
        [Embed(source = '../assets/CashierGetEggs.png')] public static var spriteBG:Class;
        [Embed(source = '../assets/CashierMom.png')] public static var spriteBubble:Class;
        [Embed(source = '../assets/checkoutloop.mp3')] public static var soundBG:Class;

        private var prompt:String;
        private var nextState:FlxState;

        public function CheckoutState(prompt:String, nextState:FlxState){
            super();
            this.prompt = prompt;
            this.nextState = nextState;
        }

        override public function create():void
        {
            endTime = 5;

            var bg:FlxSprite = new FlxSprite(0, 0);
            bg.loadGraphic(spriteBG, true, true, 320, 240, true);
            bg.addAnimation("run", [0,1], 2, true);
            add(bg);
            bg.play("run");

            var bubble:FlxSprite = new FlxSprite(110, 150, spriteBubble);
            add(bubble);

            var t:FlxText;
            t = new FlxText(115,175,120,prompt);
            t.size = 10;
            add(t);

            FlxG.playMusic(soundBG);
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
