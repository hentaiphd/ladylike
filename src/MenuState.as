package
{
    import org.flixel.*;

    public class MenuState extends FlxState{
        [Embed(source = '../assets/SplashLayer0.png')] public static var bgSprite:Class;
        [Embed(source = '../assets/SplashLayer1.png')] public static var spriteGirl:Class;

        public var t1:FlxText;
        public var t2:FlxText;
        public var t3:FlxText;
        public var t4:FlxText;
        public var t5:FlxText;
        public var bg:FlxSprite;

        override public function create():void
        {
            bg = new FlxSprite(0,0,bgSprite);
            add(bg);

            var girl:FlxSprite = new FlxSprite(135, 85);
            girl.loadGraphic(spriteGirl, true, true, 594/9, 72, true);
            girl.addAnimation("run", [0,1,2,3,4,5,6,7,8], 5, true);
            add(girl);
            girl.play("run");

            t2:FlxText;
            t2 = new FlxText(40,30,250,"A game by Nina Freeman and Emmett Butler");
            t2.alignment = "center";
            add(t2);

            t4:FlxText;
            t4 = new FlxText(40,40,250,"with audio by Deckman Coss\nand art by Winnie Song");
            t4.alignment = "center";
            add(t4);

            t5:FlxText;
            t5 = new FlxText(40,210,250,"To play, use the ENTER and arrow keys.");
            t5.alignment = "center";
            add(t5);

            t3 = new FlxText(FlxG.width/2-50,FlxG.height-20,100,"ENTER to start");
            t3.alignment = "center";
            add(t3);

            FlxG.mouse.hide();
        }

        override public function update():void
        {
            super.update();

            if(FlxG.keys.justPressed("ENTER"))
            {
                FlxG.mouse.hide();
                FlxG.switchState(new ToyStoreState());
            }
        }
    }
}
