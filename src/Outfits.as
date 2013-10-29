package
{
    import org.flixel.*;
    import org.flixel.plugin.photonstorm.*;

    public class Outfits extends FlxSprite{

        public var wasworn:Boolean = false;

        public function Outfits(x:int,y:int):void{
            super(x,y);
            makeGraphic(20,20,FlxColor.getRandomColor(20));
        }

        override public function update():void{

        }
    }
}