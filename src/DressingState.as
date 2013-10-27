package
{
    import org.flixel.*;

    public class DressingState extends FlxState{
        [Embed(source = '../assets/field.png')] public static var spriteBG:Class;

        public var clothes:Clothes;
        public var ground:Floor;
        public var timeFrame:Number = 0;
        public var timeSec:Number = 12;

        override public function create():void{
            ground = new Floor();
            add(ground);

            var bg:FlxSprite = new FlxSprite(0, 0, spriteBG);
            add(bg);

            clothes = new Clothes(150,180);
            add(clothes);
        }

        public function handleGround(clothes:Clothes, ground:FlxSprite):void{
        }

        override public function update():void{
            super.update();
            FlxG.collide(clothes, ground, handleGround);
        }
    }
}