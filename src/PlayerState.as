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

    public class PlayerState extends TimedState {
        public var player:Player;
        public var ground:Floor;

        public function _create(slippery:Boolean,grabDown:Boolean):void {
            super.create();
            ground = new Floor();

            player = new Player(150,180,slippery,grabDown);
        }

        public function makeGround():void {
            add(ground);
        }
        public function makePlayer():void {
            add(player);
        }

        override public function update():void{
            super.update();
            FlxG.collide(player, ground, handleGround);
        }

        public function handleGround(player:Player, ground:FlxSprite):void{}

        override public function endCallback():void{}
    }
}
