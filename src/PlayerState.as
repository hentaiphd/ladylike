package {
    import org.flixel.*;

    public class PlayerState extends TimedState {
        public var player:Player;
        public var ground:Floor;

        public function _create(slippery:Boolean,grabDown:Boolean):void {
            super.create();
            ground = new Floor();

            player = new Player(150,180,false,grabDown);
        }

        public function makeGround():void {
            add(ground);
        }
        public function makePlayer():void {
            add(player);
        }

        override public function update():void{
            super.update();
            FlxG.collide(player, ground, handleGround);
        }

        public function handleGround(player:Player, ground:FlxSprite):void{}

        override public function endCallback():void{}
    }
}
