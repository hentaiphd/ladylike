package
{
    import org.flixel.*;

    public class Flower extends FlxSprite{
        [Embed(source="../assets/flower.png")] private var spriteFlower:Class;
        [Embed(source="../assets/flower2.png")] private var spriteFlower2:Class;
        [Embed(source="../assets/flower3.png")] private var spriteFlower3:Class;

        public function Flower(x:int, y:int):void{
            super(x, y);

            var img:Class;
            var pick:Number = FlxG.random()*3;
            if(pick > 2){
                img = spriteFlower;
            } else if(pick > 1) {
                img = spriteFlower2;
            } else {
                img = spriteFlower3;
            }

            loadGraphic(img, true, true, 6, 12, true);
            frameWidth = 6;
            frameHeight = 12;
            width = 12;

            immovable = true;
        }
    }
}
