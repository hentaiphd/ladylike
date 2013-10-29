package
{
    import org.flixel.*;

    public class RoadState extends PlayerState{
        [Embed(source = '../assets/OutsideLayer0.png')] public static var spriteBG0:Class;
        [Embed(source = '../assets/OutsideLayer1.png')] public static var spriteBG1:Class;
        [Embed(source = '../assets/OutsideLayer2.png')] public static var spriteBG2:Class;
        [Embed(source = '../assets/Clouds.png')] public static var spriteClouds:Class;
        [Embed(source = '../assets/Brush.png')] public static var spriteBrush:Class;
        [Embed(source = '../assets/outdoorloop_lofi.mp3')] public static var sndBG:Class;
        [Embed(source = '../assets/bird1.mp3')] public static var sndBird1:Class;
        [Embed(source = '../assets/bird2_l.mp3')] public static var sndBird2L:Class;
        [Embed(source = '../assets/bird2_r.mp3')] public static var sndBird2R:Class;
        [Embed(source = '../assets/bird3_l.mp3')] public static var sndBird3L:Class;
        [Embed(source = '../assets/bird3_r.mp3')] public static var sndBird3R:Class;
        [Embed(source = '../assets/bird4_l.mp3')] public static var sndBird4L:Class;
        [Embed(source = '../assets/bird4_r.mp3')] public static var sndBird4R:Class;
        [Embed(source = '../assets/bird5_l.mp3')] public static var sndBird5L:Class;
        [Embed(source = '../assets/bird5_r.mp3')] public static var sndBird5R:Class;
        [Embed(source = '../assets/bird6_l.mp3')] public static var sndBird6L:Class;
        [Embed(source = '../assets/bird6_r.mp3')] public static var sndBird6R:Class;
        [Embed(source = '../assets/bird7_l.mp3')] public static var sndBird7L:Class;
        [Embed(source = '../assets/bird7_r.mp3')] public static var sndBird7R:Class;
        [Embed(source = '../assets/car.mp3')] public static var sndCar:Class;
        [Embed(source = '../assets/truck.mp3')] public static var sndTruck:Class;
        [Embed(source = '../assets/drivingaway.mp3')] public static var sndDriveAway:Class;
        [Embed(source = '../assets/pullingup.mp3')] public static var sndPullUp:Class;

        public var flowers:Array;
        public var clouds:FlxSprite;
        public var awayText:FlxText;

        override public function create():void{
            super._create(false, true);
            makeGround();
            var bg0:FlxSprite = new FlxSprite(0, 0, spriteBG0);
            add(bg0);
            clouds = new FlxSprite(-100, 0, spriteClouds);
            add(clouds);
            var bg1:FlxSprite = new FlxSprite(0, 0, spriteBG1);
            add(bg1);
            var bg2:FlxSprite = new FlxSprite(0, 0, spriteBG2);
            add(bg2);
            var brush:FlxSprite = new FlxSprite(0, 0);
            brush.loadGraphic(spriteBrush, true, true, 320, 240, true);
            brush.addAnimation("run", [0, 1], 1);
            add(brush);
            brush.play("run");

            awayText = new FlxText(135,10,200,"She's really gone...");
            add(awayText);

            makePlayer();

            flowers = new Array(10);
            for(var i:int = 0; i < flowers.length; i++){
                var flower:Flower = new Flower((30*i+Math.random()*40), 210+((Math.random()*8)-4));
                add(flower);
                flowers[i] = flower;
            }

            FlxG.playMusic(sndBG);
            FlxG.play(sndDriveAway);
        }


        public function playCarAmbience():void{
            var pick:Number = FlxG.random() * 1000;
            if(pick > 3) { return; }
            if (pick > 2) {
                FlxG.play(sndCar);
            } else if (pick > 1) {
                FlxG.play(sndTruck);
            }
        }

        public function playCarAmbience():void{
            var pick:Number = FlxG.random() * 1000;
            if(pick > 3) { return; }
            if (pick > 2) {
                FlxG.play(sndCar);
            } else if (pick > 1) {
                FlxG.play(sndTruck);
            }
        }

        public function playBirdAmbience():void{
            var pick:Number = FlxG.random() * 1300;
            if (pick > 7) { return; }
            if (pick > 6) {
                FlxG.play(sndBird7L, .5);
            } else if (pick > 5) {
                FlxG.play(sndBird6L, .5);
            } else if (pick > 4) {
                FlxG.play(sndBird5L, .5);
            } else if (pick > 3) {
                FlxG.play(sndBird4L, .5);
            } else if (pick > 2) {
                FlxG.play(sndBird3L, .5);
            } else if (pick > 1) {
                FlxG.play(sndBird2L, .5);
            } else if (pick > 0) {
                FlxG.play(sndBird1, .5);
            }
        }

        override public function update():void{
            super.update();

            if(timeFrame%100 == 0){
                clouds.x += 1;
                clouds.y -= 1;
            }

            if(timeSec == 5){
                awayText.kill();
            }

            if (player.grabbing) {
                for(var i:int = 0; i < flowers.length; i++){
                    if (player.overlaps(flowers[i])) {
                        flowers[i].kill();
                    }
                }
            }

            playBirdAmbience();
            playCarAmbience();
        }

        override public function endCallback():void{
            FlxG.music.stop();
            FlxG.switchState(new TextState("I came back to see if you're ready to behave.", new EndState("That kind of behavior is unacceptable, Nina... stop crying--I only left you there for like ten seconds.")));
        }
    }
}
