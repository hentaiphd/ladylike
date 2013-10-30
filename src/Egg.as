package
{
    import org.flixel.*;

    public class Egg extends FlxSprite{
        [Embed(source="../assets/EggSprite.png")] private var img:Class;

        public var held:Boolean = false;

        public function Egg(x:int, y:int):void{
            super(x, y);

            loadGraphic(img, true, true, 40, 36, true);
            frameWidth = 40;
            frameHeight = 36;
            width = 40;

            addAnimation("whole", [0]);
            addAnimation("break", [1, 2, 3, 4], 5, false);

            play("whole");

            immovable = true;
        }
    }
}
