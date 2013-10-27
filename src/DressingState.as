package
{
    import org.flixel.*;

    public class DressingState extends FlxState{
        [Embed(source = '../assets/field.png')] public static var spriteBG:Class;

        public var clothes:Clothes;
        public var ground:Floor;
        public var timeFrame:Number = 0;
        public var timeSec:Number = 0;
        public var numleft:int;
        public var momsays:FlxText;
        public var instruction:FlxText;

        override public function create():void{
            numleft = 5;

            ground = new Floor();
            add(ground);

            var bg:FlxSprite = new FlxSprite(0, 0, spriteBG);
            add(bg);

            clothes = new Clothes(150,180);
            add(clothes);

            momsays = new FlxText(5,5,100,"You picked out some clothes? Let me see.");
            FlxG.state.add(momsays);

            instruction = new FlxText(5,100,100,"ENTER to show mom.");
            FlxG.state.add(instruction);
        }

        public function handleGround(clothes:Clothes, ground:FlxSprite):void{
        }

        override public function update():void{
            super.update();
            FlxG.collide(clothes, ground, handleGround);
            timeFrame++;

            if(timeFrame%100 == 0){
                timeSec++;
            }

            if(FlxG.keys.justReleased("LEFT")) {
                clothes.changeOutfit(1);
            }else if(FlxG.keys.justReleased("RIGHT")){
                clothes.changeOutfit(2);
            }else if(FlxG.keys.justReleased("ENTER")){
                if(clothes.outfits[clothes.counter].wasworn == true){
                    momsays.text = "You already showed me that. I said I didn't like it. What else?";
                } else {
                    clothes.outfits[clothes.counter].wasworn = true;
                    numleft--;
                    momsays.text = "I don't like that. What else did you get?";
                }
            }

            if(numleft == 0){
                momsays.text = "It's getting late--we have to go. Try this last one on that I picked out for you.";
            }
        }
    }
}