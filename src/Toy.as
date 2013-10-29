package
{
    import org.flixel.*;

    public class Toy extends FlxSprite{
        [Embed(source="../assets/Flower1.png")] private var spriteFlower:Class;
        [Embed(source="../assets/Flower2.png")] private var spriteFlower2:Class;
        [Embed(source="../assets/Flower3.png")] private var spriteFlower3:Class;
        [Embed(source="../assets/Flower4.png")] private var spriteFlower4:Class;
        [Embed(source="../assets/Flower5.png")] private var spriteFlower5:Class;
        [Embed(source="../assets/Flower6.png")] private var spriteFlower6:Class;

        public function Toy(x:int, y:int):void{
            super(x, y);

            var img:Class;
            var pick:Number = FlxG.random()*6;
            if(pick > 5){
                img = spriteFlower;
            } else if(pick > 4) {
                img = spriteFlower2;
            } else if(pick > 3) {
                img = spriteFlower3;
            } else if(pick > 2) {
                img = spriteFlower4;
            } else if(pick > 1) {
                img = spriteFlower5;
            } else {
                img = spriteFlower6;
            }

            loadGraphic(img, true, true, 6, 12, true);
            frameWidth = 6;
            frameHeight = 12;
            width = 12;

            immovable = true;
        }
    }
}
