package {
    import org.flixel.*;

    public class ToyStoreState extends PlayerState {
        public var toys:Array = new Array();

        override public function create():void {
            super._create(false, false);
            makeGround();

            toys = new Array(10);
            for(var i:int = 0; i < toys.length; i++){
                var toy:Toy = new Toy((30*i+Math.random()*40), 180+((Math.random()*8)-4));
                add(toy);
                toys[i] = toy;
            }
            makePlayer();
        }


        override public function update():void {
            super.update();
            if (player.grabbing) {
                for(var i:int = 0; i < toys.length; i++){
                    if (player.overlaps(toys[i])) {
                        toys[i].kill();
                    }
                }
            }
        }

        override public function endCallback():void{
            FlxG.switchState(new TextState("What is this supposed to say", new EndState("")));
        }
    }
}
