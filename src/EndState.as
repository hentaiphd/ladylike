package
{
    import org.flixel.*;

    public class EndState extends PlayState{
        override public function buildConversation(pages:Array):Array{
            convoTree = new Array();

            var zero:ConvoBranch = new ConvoBranch("0", "That kind of behavior is unacceptable, Nina... stop crying--I only left you there for like ten seconds.");
            zero.addResponse("END // Enter to restart.", RESTART);
            convoTree[0] = zero;

            return convoTree;
        }
    }
}
