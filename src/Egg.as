package
{
    import org.flixel.*;

    public class Egg extends FlxSprite{
        [Embed(source="../assets/Flower1.png")] private var img:Class;

        public var held:Boolean = false;

        public function Egg(x:int, y:int):void{
            super(x, y);

            loadGraphic(img, true, true, 6, 12, true);
            frameWidth = 6;
            frameHeight = 12;
            width = 12;

            immovable = true;
        }
    }
}
