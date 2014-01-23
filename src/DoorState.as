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

    public class DoorState extends FlxState{
        [Embed(source = '../assets/doorclose.mp3')] public static var sndDoorClose:Class;

        public var timeFrame:Number = 0;
        public var timeSec:Number = 0;

        override public function create():void
        {
            var t:FlxText;
            t = new FlxText(0,FlxG.height/2-10,FlxG.width,"GET OUT OF THE CAR");
            t.size = 16;
            t.alignment = "center";
            add(t);
            FlxG.play(sndDoorClose);
        }

        override public function update():void
        {
            super.update();
            timeFrame++;

            if(timeFrame%100 == 0){
                timeSec++;
            }

            if(timeSec == 2){
                FlxG.switchState(new RoadState());
            }

        }
    }
}
