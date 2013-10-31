package {
    import org.flixel.*;

    public class ToyStoreState extends PlayerState {
        [Embed(source = '../assets/toyaisle.png')] public static var spriteBG:Class;
        [Embed(source = '../assets/doll.png')] public static var spriteDoll:Class;
        [Embed(source = '../assets/dollnaked.png')] public static var spriteDollNaked:Class;

        public var toys:Array = new Array();
        public var bg:FlxSprite;
        public var grabTime:int = -1;
        public var nudeTime:int = -1;
        public var doll:FlxSprite;

        override public function create():void {
            super._create(false, false);
            makeGround();

            bg = new FlxSprite(0, 0);
            bg.loadGraphic(spriteBG, true, true, 320, 240, true);
            bg.addAnimation("run", [0, 1], 1, false);
            add(bg);

            doll = new FlxSprite(100, 20);
            doll.loadGraphic(spriteDoll, true, true, 845/8, 200);
            doll.addAnimation("fwd", [0, 1, 2, 3, 4, 5, 6, 7], 4, false);
            doll.addAnimation("rev", [7, 6, 5, 4, 3, 2, 1, 0], 4, false);

            toys = new Array(1);
            for(var i:int = 0; i < toys.length; i++){
                var toy:Toy = new Toy(100, 184);
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
                        bg.play("run");
                        grabTime = timeSec;
                        player.no_control = true;
                        var smoke:FlxSprite = new FlxSprite(0, 0);
                        smoke.makeGraphic(320, 240, 0x88000000);
                        add(smoke);
                        add(doll);
                    }
                }
            }

            if (grabTime != -1) {
                if(FlxG.keys.justPressed("LEFT")) {
                    doll.play("fwd");
                } else if (FlxG.keys.justPressed("RIGHT")){
                    doll.play("rev");
                } else if (FlxG.keys.justPressed("ENTER")){
                    doll.loadGraphic(spriteDollNaked, true, true, 845/8, 200, true);
                    nudeTime = timeSec;
                }
            }

            if (nudeTime != -1){
                if (timeSec - nudeTime >= 10){
                    FlxG.switchState(new TextState("What is this supposed to say", new EndState("")));
                }
            }
        }

    }
}
