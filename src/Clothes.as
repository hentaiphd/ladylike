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

        public function Clothes(x:int,y:int):void{
            super(x,y);

            counter = 0;

            outfits = new Array();

            outfit0 = new Outfits(x,y);
            outfits[0] = outfit0;
            outfit1 = new Outfits(x,y);
            outfits[1] = outfit1;
            outfit2 = new Outfits(x,y);
            outfits[2] = outfit2;
            outfit3 = new Outfits(x,y);
            outfits[3] = outfit3;
            outfit4 = new Outfits(x,y);
            outfits[4] = outfit4;

            FlxG.state.add(outfits[0]);
        }

        public function changeOutfit(direction:int):void{
            FlxG.state.remove(outfits[counter]);
            if(direction == 1){
                counter--;
                if(counter < 0){
                    counter = 4;
                }
            }else if(direction == 2){
                counter++;
                if(counter == 5){
                    counter = 0;

                }
            }
            FlxG.state.add(outfits[counter]);
        }

        override public function update():void{
            super.update();
        }
    }
}
