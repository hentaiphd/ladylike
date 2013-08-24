package{
    import org.flixel.*;

    public class Convo extends FlxSprite{

    	public var choices:Array;
    	public var choicePos:Array;
    	public var choicesRef:Array;
    	public var momWords:FlxText;

    	public function Convo(ref:Array):void{
    		choicesRef = ref;
    		choices = new Array(choicesRef.length);
    		choicePos = new Array(choicesRef.length);
    	}

    	public function momSays(x:int,y:int,words:String):void{
    		momWords = new FlxText(x,y,100,words);
    		FlxG.state.add(momWords);
    	}

    	public function newConvo(x:int,y:int):void{
    		var yCalc:int = y;
    		for(var i:int = 0; i < choicesRef.length; i++){
    			yCalc+=5+(i*10);
    			choices[i] = oneReply(choicesRef[i],x,yCalc);
    			choicePos[i] = yCalc;
    		}
    	}

    	public function oneReply(i:String,x:int,y:int):void{
			var newReply:FlxText = new FlxText(x,y,100,i);
			FlxG.state.add(newReply);
    	}

    	override public function update():void{
    		/*for(var i = 0; i < choices.length; i++){
    			if(FlxG.keys.LEFT){

    			}
    		}*/
    	}
    }
}