package
{
    import org.flixel.*;
    import org.flixel.plugin.photonstorm.*;

    public class Food extends FlxSprite{
        public var foodName:String;
        public var foodNameText:FlxText;

        public function Food(x:int, y:int):void{
            var ranW:Number = Math.random()*FlxG.width/2;
            var ranH:Number = Math.random()*FlxG.height/2;
            makeGraphic(ranW,ranH,FlxColor.getRandomColor());
            this.x = x;
            this.y = y;
        }

        override public function update():void{
            foodNameText.x = this.x;
            foodNameText.y = this.y;
        }
    }
}