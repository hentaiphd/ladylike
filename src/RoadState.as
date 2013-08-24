package
{
    import org.flixel.*;

    public class RoadState extends FlxState{
        public var player:Player;
        public var ground:Floor;

        override public function create():void{
            player = new Player(20,20);
            add(player);

            ground = new Floor();
            add(ground);

        }
    
        override public function update():void{
            super.update();
            FlxG.collide();
        }
    }
}