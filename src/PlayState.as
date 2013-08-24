package
{
	import org.flixel.*;

	public class PlayState extends FlxState{
		public var convo:Convo;
		public var convoTree:Array;
		public var selector:Selector;
		public var posX:int = 50;
    	public var posY:int = 50;

		override public function create():void{
			convo = new Convo();

			convo.momSays(200,10,"WTF Nina");
			convo.newConvo("onee","twooooooo","threeeeeeeeeee",posX,posY);
			selector = new Selector(posX-5,convo.choicePos);
			add(convo);
			add(selector);
			
		}

		public function buildConversation():void{
			convoTree = new Array();

			var zero:ConvoBranch = new ConvoBranch(0, "I'm mom");
			zero.addResponse("i know", 1);
			zero.addResponse("yup", 1);
			convoTree.[0] = zero;

			var one:ConvoBranch = new ConvoBranch(1, "part 2");
			one.addResponse("i know", 2);
			one.addResponse("yup", 2);
			convoTree.[1] = one;

			
		}
	}
}
