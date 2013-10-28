package {
    import org.flixel.*;

    public class MallState extends TimedState {
        [Embed(source = '../assets/MallLayer0.png')] public static var spriteBG:Class;
        [Embed(source = '../assets/MallLayer1.png')] public static var spriteFriend:Class;
        [Embed(source = '../assets/MallLayer2.png')] public static var spriteGirl:Class;
        [Embed(source = '../assets/foodcourtloop.mp3')] public static var sndBG:Class;

        private var prompt:String;
        private var nextState:FlxState;

        public function MallState(prompt:String, nextState:FlxState){
            super();
            this.prompt = prompt;
            this.nextState = nextState;
        }

        override public function create():void
        {
            endTime = 5;

            var bg:FlxSprite = new FlxSprite(0, 0, spriteBG);
            add(bg);
            var friend:FlxSprite = new FlxSprite(20, 80);
            friend.loadGraphic(spriteFriend, true, true, 116, 166, true);
            friend.addAnimation("run", [0, 1], 3, true);
            add(friend);
            friend.play("run");
            var girl:FlxSprite = new FlxSprite(150, 80, spriteGirl);
            add(girl);

            var t:FlxText;
            t = new FlxText(0,20,FlxG.width,prompt);
            t.size = 14;
            t.alignment = "center";
            add(t);

            FlxG.playMusic(sndBG);
        }

        override public function update():void
        {
            super.update();
        }

        override public function endCallback():void {
            FlxG.switchState(this.nextState);
        }
    }
}
