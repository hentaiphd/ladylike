package
{
    import org.flixel.*;

    public class LeaveMallState extends FlxState{
        public var timeFrame:Number = 0;
        public var timeSec:Number = 0;

        override public function create():void
        {
            var t:FlxText;
            t = new FlxText(0,FlxG.height/2-10,FlxG.width,"You're welcome for the nice clothes. Let's go.");
            t.size = 16;
            t.alignment = "center";
            add(t);
        }

        override public function update():void
        {
            super.update();
            timeFrame++;

            if(timeFrame%100 == 0){
                timeSec++;
            }

            if(timeSec == 2){
                FlxG.switchState(new EndState());
            }

        }
    }
}