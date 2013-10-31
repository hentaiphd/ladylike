package {
    import org.flixel.*;

    public class ToyStoreState extends PlayerState {
        [Embed(source = '../assets/toyaisle.png')] public static var spriteBG:Class;
        public var toys:Array = new Array();

        override public function create():void {
            super._create(false, false);
            makeGround();

            var bg:FlxSprite = new FlxSprite(0, 0);
            bg.loadGraphic(spriteBG, true, true, 320, 240, true);
            bg.addAnimation("run", [0, 1], 1, false);
            add(bg);
            bg.play("run");

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
