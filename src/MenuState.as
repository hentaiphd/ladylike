package
{
    import org.flixel.*;

    public class MenuState extends FlxState{
        [Embed(source = '../assets/field.png')] public static var bgSprite:Class;

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

            t1:FlxText;
            t1 = new FlxText(0,10,FlxG.width,"LADYLIKE");
            t1.size = 16;
            t1.alignment = "center";
            add(t1);

            t2:FlxText;
            t2 = new FlxText(40,30,250,"A game by Nina Freeman and Emmett Butler");
            t2.alignment = "center";
            add(t2);

            t4:FlxText;
            t4 = new FlxText(40,40,250,"with audio by Deckman Coss");
            t4.alignment = "center";
            add(t4);

            var jam:FlxText;
            jam = new FlxText(40,50,250,"Ludum Dare 27");
            jam.alignment = "center";
            add(jam);

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
                FlxG.switchState(new PlayState());
            }
        }
    }
}
