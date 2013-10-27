package
{
    import org.flixel.*;

    public class CootieState extends FlxState{
        [Embed(source = '../assets/field.png')] public static var spriteBG:Class;

        public var promptText:FlxText;
        private var selector:Selector;
        private var choicePositions:Array;

        private static var NO_RESULT:int = -1;

        override public function create():void{
            var bg:FlxSprite = new FlxSprite(0, 0, spriteBG);
            //add(bg);

            promptText = new FlxText(135,10,200,"Let's play cootie catcher");
            add(promptText);

            choicePositions = new Array(
                new FlxPoint(150, 100), new FlxPoint(200, 150),
                new FlxPoint(100, 150), new FlxPoint(150, 200)
            );

            selector = Selector.newFromPoints(choicePositions);
            add(selector);
        }

        override public function update():void{
            super.update();
        }

        private function getChoice():int{
            if (FlxG.keys.justPressed("ENTER")) {
                return selector.getIndex();
            }
            return NO_RESULT;
        }
    }
}
