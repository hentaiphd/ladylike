package{
    import org.flixel.*;

    public class Selector extends FlxSprite{
        [Embed(source = '../assets/bliplow.mp3')] public static var sndLoBlip:Class;

        private var _index:int = 0;
        private var refXArray:Array;
        private var refYArray:Array;

        public function Selector(xArray:Array, yArray:Array):void{
            super(xArray[0],y = yArray[0] + 5);
            refYArray = yArray;
            refXArray = xArray;
            this.makeGraphic(5,5,0xFFFFFFFF);
            this.width = 5;
            this.height = 5;
        }

        public static function newFromPoints(points:Array):Selector {
            var xPositions:Array = new Array();
            var yPositions:Array = new Array();
            for(var i:int = 0; i < points.length; i++) {
                xPositions.push(points[i].x);
                yPositions.push(points[i].y);
            }
            return new Selector(xPositions, yPositions);
        }

        override public function update():void{
            if(FlxG.keys.justPressed("DOWN") || FlxG.keys.justPressed("RIGHT")){
                FlxG.play(sndLoBlip);
                if(_index < refYArray.length - 1){
                    _index++;
                } else {
                    _index = 0;
                }
            } else if (FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("LEFT")){
                FlxG.play(sndLoBlip);
                if(_index > 0){
                    _index--;
                } else {
                    _index = refYArray.length - 1;
                }
            }
            x = refXArray[_index];
            y = refYArray[_index];
        }

        public function getIndex():int{
            return _index;
        }
    }
}
