package
{
    import org.flixel.*;

    public class RoadState extends FlxState{
        [Embed(source = '../assets/field.png')] public static var spriteBG:Class;

        public var player:Player;
        public var ground:Floor;
        public var timeFrame:Number = 0;
        public var timeSec:Number = 0;
        public var flowers:Array;

        override public function create():void{
            ground = new Floor();
            add(ground);

            var bg:FlxSprite = new FlxSprite(0, 0, spriteBG);
            add(bg);

            player = new Player(20,180);
            add(player);

            flowers = new Array(10);
            for(var i:int = 0; i < flowers.length; i++){
                var flower:Flower = new Flower((30*i+Math.random()*40), 210);
                add(flower);
                flowers[i] = flower;
            }
        }

        public function handleGround(player:Player, ground:FlxSprite):void{}

        override public function update():void{
            super.update();
            FlxG.collide(player, ground, handleGround);
            timeFrame++;

            if(timeFrame%100 == 0){
                timeSec++;
            }

            if(timeSec == 10){
                FlxG.switchState(new DoorInState());
            }

            if (player.grabbing) {
                for(var i:int = 0; i < flowers.length; i++){
                    if (player.overlaps(flowers[i])) {
                        flowers[i].kill();
                    }
                }
            }
        }
    }
}
