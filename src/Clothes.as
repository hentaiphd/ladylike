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

    public class Clothes extends FlxSprite{
        [Embed(source="../assets/girl_sprites_new.png")] private var ImgPlayer:Class;

        public var outfits:Array;
        public var counter:int;
        public var outfit0:Outfits;
        public var outfit1:Outfits;
        public var outfit2:Outfits;
        public var outfit3:Outfits;
        public var outfit4:Outfits;
        public var outfit5:Outfits;
        public var outfit6:Outfits;
        public var outfit7:Outfits;

        public function Clothes(x:int,y:int):void{
            super(x,y);

            counter = 0;

            outfits = new Array();

            outfit0 = new Outfits(x,y,0);
            outfits[0] = outfit0;
            outfit1 = new Outfits(x,y,1);
            outfits[1] = outfit1;
            outfit2 = new Outfits(x,y,2);
            outfits[2] = outfit2;
            outfit3 = new Outfits(x,y,3);
            outfits[3] = outfit3;
            outfit4 = new Outfits(x,y,4);
            outfits[4] = outfit4;
            outfit5 = new Outfits(x,y,5);
            outfits[5] = outfit5;
            outfit6 = new Outfits(x,y,6);
            outfits[6] = outfit6;
            outfit7 = new Outfits(x,y,7);
            outfits[7] = outfit7;

            FlxG.state.add(outfits[0]);
        }

        public function changeOutfit(direction:int):void{
            FlxG.state.remove(outfits[counter]);
            if(direction == 1){
                counter--;
                if(counter < 0){
                    counter = outfits.length-1;
                }
            }else if(direction == 2){
                counter++;
                if(counter > outfits.length-1){
                    counter = 0;
                }
            }
            FlxG.state.add(outfits[counter]);
        }
    }
}
