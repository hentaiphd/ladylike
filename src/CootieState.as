package
{
    import org.flixel.*;

    public class RoadState extends FlxState{
        [Embed(source = '../assets/field.png')] public static var spriteBG:Class;

        public var promptText:FlxText;

        override public function create():void{
            var bg:FlxSprite = new FlxSprite(0, 0, spriteBG);
            add(bg);

            promptText = new FlxText(135,10,200,"Let's play cootie catcher");
            add(promptText);
        }

        override public function update():void{
            super.update();
        }
    }
}
