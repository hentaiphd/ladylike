/*
    This file is part of Ladylike's source.

    Ladylike's source is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Ladylike's source is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with Ladylike's source. If not, see <http://www.gnu.org/licenses/>.
*/

package
{
    import org.flixel.*;

    public class DressingState extends TimedState{
        [Embed(source = '../assets/ChangeroomLayer0.png')] public static var spriteBG:Class;
        [Embed(source="../assets/Outfit1.png")] private var spriteOutfit0:Class;
        [Embed(source="../assets/Outfit2.png")] private var spriteOutfit1:Class;
        [Embed(source="../assets/Outfit3.png")] private var spriteOutfit2:Class;
        [Embed(source="../assets/Outfit4.png")] private var spriteOutfit3:Class;
        [Embed(source="../assets/Outfit5.png")] private var spriteOutfit4:Class;
        [Embed(source="../assets/Outfit6.png")] private var spriteOutfit5:Class;
        [Embed(source="../assets/Outfit7.png")] private var spriteOutfit6:Class;
        [Embed(source="../assets/Outfit8.png")] private var spriteOutfit7:Class;
        [Embed(source="../assets/MomInsult.png")] private var spriteBubble:Class;
        [Embed(source = '../assets/fittingroomloop2.mp3')] public static var sndBG:Class;
        [Embed(source = '../assets/bliphigh.mp3')] public static var sndHiBlip:Class;
        [Embed(source = '../assets/bliplow.mp3')] public static var sndLoBlip:Class;

        public var clothes:Clothes;
        public var stopTime:int = 0;
        public var numleft:int;
        public var momsays:FlxText;
        public var selectTime:int = 0;
        public var instruction:FlxText;
        public var bg:FlxSprite;
        public var hangers:Array = new Array();

        override public function create():void{
            super.create();
            numleft = 5;

            bg = new FlxSprite(0, 0);
            bg.loadGraphic(spriteBG, true, true, 320, 240, true);
            bg.addAnimation("curtain", [1, 0], 1, false);
            add(bg);

            var speechBubble:FlxSprite = new FlxSprite(60, 20, spriteBubble);
            add(speechBubble);

            clothes = new Clothes(130,97);
            clothes.immovable = true;

            momsays = new FlxText(90,20,140,"You picked out some clothes? Let me see.");
            FlxG.state.add(momsays);

            instruction = new FlxText(5,200,100,"ENTER to show mom.");
            FlxG.state.add(instruction);

            hangers.push(new FlxSprite(79, 78, spriteOutfit0));
            hangers.push(new FlxSprite(185, 94, spriteOutfit1));
            hangers.push(new FlxSprite(218, 49, spriteOutfit2));
            hangers.push(new FlxSprite(263, 16, spriteOutfit3));
            hangers.push(new FlxSprite(241, 94, spriteOutfit4));
            hangers.push(new FlxSprite(283, 75, spriteOutfit5));
            hangers.push(new FlxSprite(263, 144, spriteOutfit6));

            for(var i:int = 0; i < hangers.length; i++){
                add(hangers[i]);
            }

            FlxG.playMusic(sndBG);
        }

        override public function update():void{
            super.update();

            if (stopTime == 0){
                if(FlxG.keys.justReleased("LEFT")) {
                    FlxG.play(sndHiBlip);
                    clothes.changeOutfit(1);
                } else if(FlxG.keys.justReleased("RIGHT")){
                    FlxG.play(sndHiBlip);
                    clothes.changeOutfit(2);
                } else if(FlxG.keys.justReleased("ENTER")){
                    FlxG.play(sndLoBlip);
                    selectTime = timeSec;
                    momsays.color = 0xFFFF0000;
                    bg.play("curtain");
                    if(clothes.outfits[clothes.counter].wasworn == true){
                        momsays.text = "You already showed me that. I said I didn't like it. What else?";
                    } else {
                        clothes.outfits[clothes.counter].wasworn = true;
                        numleft--;
                        momsays.text = "I don't like that. What else did you get?";
                    }
                }
            }

            if (timeSec - selectTime > 0) {
                momsays.color = 0xFFFFFFFF;
            }
            if(numleft == 0 && stopTime == 0){
                momsays.text = "It's getting late--we have to go. Try this last one on that I picked out for you.";
                stopTime = timeSec;
            }
            if(stopTime != 0 && timeSec - stopTime >= 5){
                FlxG.switchState(new TextState("You're welcome for the nice clothes. Let's go.", new EndState("Those graphic T-shirts are so tacky.")));
            }
        }
    }
}
