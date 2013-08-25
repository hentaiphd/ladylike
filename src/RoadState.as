package
{
    import org.flixel.*;

    public class RoadState extends FlxState{
        [Embed(source = '../assets/field.png')] public static var spriteBG:Class;

        public var player:Player;
        public var ground:Floor;
        public var timeFrame:Number = 0;
        public var timeSec:Number = 0;

        override public function create():void{
            ground = new Floor();
            add(ground);

            var bg:FlxSprite = new FlxSprite(0, 0, spriteBG);
            add(bg);

            player = new Player(20,180);
            add(player);

        }

        override public function update():void{
            super.update();
            FlxG.collide();
            timeFrame++;

            if(timeFrame%100 == 0){
                timeSec++;
            }

            if(timeSec == 10){
                FlxG.switchState(new DoorInState());
            }
        }
    }
}
