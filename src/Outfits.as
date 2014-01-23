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
    import org.flixel.plugin.photonstorm.*;

    public class Outfits extends FlxSprite{
        [Embed(source="../assets/ChangeroomLayer1.png")] private var spriteGirl:Class;

        public var wasworn:Boolean = false;

        public function Outfits(x:int,y:int,pick:int):void{
            super(x,y);

            loadGraphic(spriteGirl, true, true, 56, 132, true);
            addAnimation("0", [0], 1, false);
            addAnimation("1", [1], 1, false);
            addAnimation("2", [2], 1, false);
            addAnimation("3", [3], 1, false);
            addAnimation("4", [4], 1, false);
            addAnimation("5", [5], 1, false);
            addAnimation("6", [6], 1, false);
            addAnimation("7", [7], 1, false);

            if (pick == 7) {
                play("0");
            } else if (pick == 6){
                play("1");
            } else if (pick == 5) {
                play("2");
            } else if (pick == 4) {
                play("3");
            } else if (pick == 3) {
                play("4");
            } else if (pick == 2) {
                play("5");
            } else if (pick == 1) {
                play("6");
            } else {
                play("7");
            }
        }

        override public function update():void{

        }
    }
}
