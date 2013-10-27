package
{
    import org.flixel.*;
    import org.flixel.plugin.photonstorm.*;

    public class Outfits extends FlxSprite{
        [Embed(source="../assets/girl_sprites.png")] private var ImgPlayer:Class;

        public var outfits:Array;

        public function Outfits(x:int,y:int):void{
            super(x,y);
            outfits = new Array();
            for(var i:int = 0; i < 5; i++){
                var a:FlxSprite = makeGraphic(20,20,FlxColor.getRandomColor(20));
                outfits[i] = a;
            }
        }

        override public function update():void{

        }
    }
}