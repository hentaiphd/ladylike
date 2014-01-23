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

package{
    import org.flixel.*;

    public class Convo {

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
            momWords = new FlxText(PlayState.momTextX,PlayState.momTextY,220,words);
            FlxG.state.add(momWords);
        }

        public function newConvo(x:int,y:int):void{
            this.selectX = x;
            this.selectY = y;
            var yCalc:int = y;
            for(var i:int = 0; i < choicesRef.length; i++){
                yCalc += 20;
                choices[i] = oneReply(choicesRef[i],x,yCalc);
                choicePos[i] = yCalc + 5;
            }
        }

        public function oneReply(i:String,x:int,y:int):FlxText{
            var newReply:FlxText = new FlxText(x,y,235,i);
            FlxG.state.add(newReply);
            return newReply;
        }

        public function start():void{
            this.momSays();
            var xArr:Array = new Array();
            for (var i:int = 0; i < this.choicePos.length; i++) {
                xArr.push(this.selectX-5);
            }
            selector = new Selector(xArr,this.choicePos);
            FlxG.state.add(selector);
        }

        public function kill():void{
            for(var i:int = 0; i < choicesRef.length; i++){
                if (choices[i]) {
                    choices[i].kill();
                }
            }
            selector.kill();
            momWords.kill();
        }

        public function getInput():String{
            if (FlxG.keys.justPressed("ENTER")){
                return curBranch.responsePointers[this.selector.getIndex()];
            }
            return PlayState.NO_RESULT;
        }
    }
}
