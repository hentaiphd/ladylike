package
{
    import org.flixel.*;

    public class EndState extends PlayState{

        public var prompt:String;

        public function EndState(prompt:String){
            super();
            this.prompt = prompt;
        }

        override public function buildConversation(pages:Array):Array{
            convoTree = new Array();

            var zero:ConvoBranch = new ConvoBranch("Start", prompt);
            zero.addResponse("END // Enter to restart.", "RESTART");
            convoTree[0] = zero;

            return convoTree;
        }
    }
}
