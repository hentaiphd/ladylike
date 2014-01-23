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

    public class WigglySprite extends FlxSprite{

        public var anchor:FlxPoint;

        public function WigglySprite(x:Number, y:Number, sprite:Class=null){
            super(x, y, sprite);
            anchor = new FlxPoint(x, y);
        }

        override public function update():void{
            if (x < anchor.x + 2){
                x += Math.random();
            } else if (x > anchor.x){
                x -= Math.random();
            }
        }
    }
}
