package
{
    import org.flixel.*;

    public class RoadState extends FlxState{
        public var player:Player;
        public var ground:Floor;
        public var timeFrame:Number = 0;
        public var timeSec:Number = 0;

        override public function create():void{
            player = new Player(20,20);
            add(player);

            ground = new Floor();
            add(ground);

        }
    
        override public function update():void{
            super.update();
            FlxG.collide();
            timeFrame++;

            if(timeFrame%100 == 0){
                timeSec++;
            }

            if(timeSec == 10){
                FlxG.switchState(new EndState());
            }
        }
    }
}