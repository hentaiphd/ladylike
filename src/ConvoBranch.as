package{
    import org.flixel.*;

    public class ConvoBranch{
    	public var momSentence:String;
    	public var responses:Array = new Array();
    	public var responsePointers:Array = new Array();
    	public var _id:Number;

    	public function ConvoBranch(id:Number, sentence:String){
    		_id = id;
    		momSentence = sentence;
    	}

    	public function addResponse(oneResponse:String, pointer:Number){
    		responses[0] = oneResponse;
    		responsePointers[0] = pointer;
    	}
    }
}