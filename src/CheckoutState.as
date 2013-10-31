package {
    import org.flixel.*;

    public class CheckoutState extends TimedState {
        [Embed(source = '../assets/CashierGetEggs.png')] public static var spriteBG:Class;
        [Embed(source = '../assets/CashierMom.png')] public static var spriteBubble:Class;
        [Embed(source = '../assets/checkoutloop.mp3')] public static var soundBG:Class;

        private var prompt:String;
        private var nextState:FlxState;

        public function CheckoutState(prompt:String, nextState:FlxState){
            super();
            this.prompt = prompt;
            this.nextState = nextState;
        }

        override public function create():void
        {
            endTime = 5;

            var bg:FlxSprite = new FlxSprite(0, 0);
            bg.loadGraphic(spriteBG, true, true, 320, 240, true);
            bg.addAnimation("run", [0,1], 2, true);
            add(bg);
            bg.play("run");

            var bubble:FlxSprite = new FlxSprite(110, 150, spriteBubble);
            add(bubble);

            var t:FlxText;
            t = new FlxText(115,175,120,prompt);
            t.size = 10;
            add(t);

            FlxG.playMusic(soundBG);
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
