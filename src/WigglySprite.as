package
{
    import org.flixel.*;

    public class WigglySprite extends FlxSprite{

        public var anchor:FlxPoint;

        public function WigglySprite(x:Number, y:Number, sprite:Class=null){
            super(x, y, sprite);
            anchor = new FlxPoint(x, y);
        }

        override public function update():void{
            if (x < anchor.x + 2){
                x += Math.random();
            } else if (x > anchor.x){
                x -= Math.random();
            }
        }
    }
}
