package{
    import org.flixel.*;

    public class Selector extends FlxSprite{
        public var refArray:Array;
        public var posY:int = 0;

    	public function Selector(x:int,yArray:Array):void{
            super(x,y = yArray[0]);
            refArray = yArray;
    		this.makeGraphic(5,5,0xFFFFFFFF);
            this.width = 5;
            this.height = 5;
    	}

    	override public function update():void{
    		if(FlxG.keys.justPressed("DOWN")){
                if(posY < 2){
                    posY++;
                    y = refArray[posY];
                } else {
                    y = refArray[0];
                    posY = 0;
                }
            }
        }
    }
}
