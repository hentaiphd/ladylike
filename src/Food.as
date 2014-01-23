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

    public class Food extends FlxSprite{
        public var foodName:String;
        public var foodNameText:FlxText;

        public function Food(x:int, y:int):void{
            var ranW:Number = Math.random()*FlxG.width/2;
            var ranH:Number = Math.random()*FlxG.height/2;
            makeGraphic(ranW,ranH,FlxColor.getRandomColor());
            this.x = x;
            this.y = y;
        }

        override public function update():void{
            foodNameText.x = this.x;
            foodNameText.y = this.y;
        }
    }
}
