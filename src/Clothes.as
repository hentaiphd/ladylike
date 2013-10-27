package
{
    import org.flixel.*;

    public class Clothes extends FlxSprite{
        [Embed(source="../assets/girl_sprites.png")] private var ImgPlayer:Class;

        public var outfit:Outfits;
        public var counter:int;

        public function Clothes(x:int,y:int):void{
            super(x,y);
            loadGraphic(ImgPlayer, true, true, 24, 40, true);

            counter = 0;

            outfit = new Outfits(x,y);
            FlxG.state.add(outfit.outfits[counter]);
        }

        override public function update():void{
            super.update();

            if(FlxG.keys.LEFT) {
                counter++;
                if(counter == 5){
                    counter = 0;
                } else {
                    outfit.kill();
                    FlxG.state.add(outfit.outfits[counter]);
                }
            } else if(FlxG.keys.RIGHT){
                counter--;
                if(counter < 0){
                    counter = 5;
                } else {
                    outfit.kill();
                    FlxG.state.add(outfit.outfits[counter]);
                }
            }
        }
    }
}