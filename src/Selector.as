package{
    import org.flixel.*;

    public class Selector extends FlxSprite{
        [Embed(source = '../assets/bliplow.mp3')] public static var sndLoBlip:Class;

        private var xIndex:int = 0;
        private var refXArray:Array;
        private var yIndex:int = 0;
        private var refYArray:Array;

        public function Selector(xArray:Array,yArray:Array):void{
            super(xArray[0],y = yArray[0] + 5);
            refYArray = yArray;
            refXArray = xArray;
            this.makeGraphic(5,5,0xFFFFFFFF);
            this.width = 5;
            this.height = 5;
        }

        override public function update():void{
            if(FlxG.keys.justPressed("DOWN")){
                FlxG.play(sndLoBlip);
                if(yIndex < refYArray.length - 1){
                    yIndex++;
                } else {
                    yIndex = 0;
                }
            } else if (FlxG.keys.justPressed("UP")){
                FlxG.play(sndLoBlip);
                if(yIndex > 0){
                    yIndex--;
                } else {
                    yIndex = refYArray.length - 1;
                }
            }
            if(FlxG.keys.justPressed("LEFT")){
                FlxG.play(sndLoBlip);
                if(xIndex > 0){
                    xIndex--;
                } else {
                    xIndex = refXArray.length - 1;
                }
            } else if (FlxG.keys.justPressed("RIGHT")){
                FlxG.play(sndLoBlip);
                if(xIndex < refXArray.length - 1){
                    xIndex++;
                } else {
                    xIndex = 0;
                }
            }
            x = refXArray[xIndex];
            y = refYArray[yIndex];
        }

        public function getIndices():Array {
            var ret:Array = new Array();
            ret.push(xIndex);
            ret.push(yIndex);
            return ret;
        }
    }
}
