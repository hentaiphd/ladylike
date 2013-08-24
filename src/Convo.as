package{
    import org.flixel.*;

    public class Convo extends FlxSprite{

    	public var choices:Array;
    	public var choicePos:Array;
    	public var momWords:FlxText;

    	public function Convo():void{
    		choices = new Array(3);
    		choicePos = new Array(3);
    	}

    	public function momSays(x:int,y:int,words:String):void{
    		momWords = new FlxText(x,y,100,words);
    		FlxG.state.add(momWords);
    	}

    	public function newConvo(choice1:String,choice2:String,choice3:String,x:int,y:int):void{
    		choices[0] = oneReply(choice1,x,y);
    		choicePos[0] = y + 5;
    		choices[1] = oneReply(choice2,x,y+10);
    		choicePos[1] = y+15;
    		choices[2] = oneReply(choice3,x,y+20);
    		choicePos[2] = y+25;
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