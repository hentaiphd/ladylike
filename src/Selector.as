package{
    import org.flixel.*;

    public class Selector extends FlxSprite{
        [Embed(source = '../assets/bliplow.mp3')] public static var sndLoBlip:Class;

        public var refArray:Array;
        public var posY:int = 0;

        public function Selector(x:int,yArray:Array):void{
            super(x,y = yArray[0] + 5);
            refArray = yArray;
            this.makeGraphic(5,5,0xFFFFFFFF);
            this.width = 5;
            this.height = 5;
        }

        override public function update():void{
            if(FlxG.keys.justPressed("DOWN")){
                FlxG.play(sndLoBlip);
                if(posY < refArray.length - 1){
                    posY++;
                } else {
                    posY = 0;
                }
            } else if (FlxG.keys.justPressed("UP")){
                FlxG.play(sndLoBlip);
                if(posY > 0){
                    posY--;
                } else {
                    posY = refArray.length - 1;
                }
            }

            y = refArray[posY] + 5;
        }
    }
}
