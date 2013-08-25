package{
    import org.flixel.*;

    public class Convo extends FlxSprite{

        public var choices:Array;
        public var choicePos:Array;
        public var choicesRef:Array;
        public var momWords:FlxText;
        public var selectX:Number;
        public var selectY:Number;
        public var selector:Selector;
        public var curBranch:ConvoBranch;

        public function Convo(ref:ConvoBranch):void{
            choicesRef = ref.responses;
            curBranch = ref;
            choices = new Array(choicesRef.length);
            choicePos = new Array(choicesRef.length);
        }

        public function momSays():void{
            var words:String = this.curBranch.momSentence;
            momWords = new FlxText(180,80,130,words);
            FlxG.state.add(momWords);
        }

        public function newConvo(x:int,y:int):void{
            this.selectX = x;
            this.selectY = y;
            var yCalc:int = y;
            for(var i:int = 0; i < choicesRef.length; i++){
                yCalc += 30;
                choices[i] = oneReply(choicesRef[i],x,yCalc);
                choicePos[i] = yCalc;
            }
        }

        public function oneReply(i:String,x:int,y:int):FlxText{
            var newReply:FlxText = new FlxText(x,y,150,i);
            FlxG.state.add(newReply);
            return newReply;
        }

        public function start():void{
            this.momSays();
            selector = new Selector(this.selectX-5,this.choicePos);
            FlxG.state.add(selector);
        }

        override public function kill():void{
            for(var i:int = 0; i < choicesRef.length; i++){
                if (choices[i]) {
                    choices[i].kill();
                }
            }
            selector.kill();
            momWords.kill();
            super.kill();
        }

        public function getInput():Number{
            if (FlxG.keys.justPressed("ENTER")){
                return curBranch.responsePointers[this.selector.posY];
            }
            return PlayState.NO_RESULT;
        }
    }
}
