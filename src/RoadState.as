package
{
    import org.flixel.*;

    public class RoadState extends FlxState{
        [Embed(source = '../assets/OutsideLayer0.png')] public static var spriteBG0:Class;
        [Embed(source = '../assets/OutsideLayer1.png')] public static var spriteBG1:Class;
        [Embed(source = '../assets/OutsideLayer2.png')] public static var spriteBG2:Class;
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

        public var player:Player;
        public var ground:Floor;
        public var timeFrame:Number = 0;
        public var timeSec:Number = 0;
        public var flowers:Array;
        public var awayText:FlxText;

        override public function create():void{
            ground = new Floor();
            add(ground);

            var bg0:FlxSprite = new FlxSprite(0, 0, spriteBG0);
            add(bg0);
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

            player = new Player(150,180,false);
            add(player);

            flowers = new Array(10);
            for(var i:int = 0; i < flowers.length; i++){
                var flower:Flower = new Flower((30*i+Math.random()*40), 210);
                add(flower);
                flowers[i] = flower;
            }

            FlxG.playMusic(sndBG);
            FlxG.play(sndDriveAway);
        }

        public function handleGround(player:Player, ground:FlxSprite):void{}

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
            FlxG.collide(player, ground, handleGround);
            timeFrame++;

            if(timeFrame%100 == 0){
                timeSec++;
            }

            if(timeSec == 5){
                awayText.kill();
            }

            var sadTime:Number = 30;
            if(timeSec == sadTime){
                FlxG.music.stop();
                FlxG.switchState(new DoorInState());
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
    }
}
