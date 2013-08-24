package
{
    import org.flixel.*;

    public class Floor extends FlxSprite{

        public function Floor():void{
            super(0,220);
            makeGraphic(400,20,0xFFFFFFFF);
            immovable = true;
        }

        override public function update():void{
            this.x = 0;
            this.y = 220;
        }
    }
}