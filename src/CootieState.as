package
{
    import org.flixel.*;

    public class CootieState extends FlxState{
        [Embed(source = '../assets/field.png')] public static var spriteBG:Class;

        public var promptText:FlxText;
        private var selector:Selector;

        override public function create():void{
            var bg:FlxSprite = new FlxSprite(0, 0, spriteBG);
            //add(bg);

            promptText = new FlxText(135,10,200,"Let's play cootie catcher");
            add(promptText);

            selector = new Selector(
                new Array(100, 200),
                new Array(100, 200)
            );
            add(selector);
        }

        override public function update():void{
            super.update();
        }
    }
}
