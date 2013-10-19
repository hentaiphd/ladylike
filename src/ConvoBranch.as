package{
    import org.flixel.*;

    public class ConvoBranch{
        public var momSentence:String;
        public var responses:Array = new Array();
        public var responsePointers:Array = new Array();
        public var _id:String;

        public function ConvoBranch(id:String, sentence:String){
            _id = id;
            momSentence = sentence;
        }

    	public function addResponse(oneResponse:String, pointer:String):void{
    		responses.push(oneResponse);
    		responsePointers.push(pointer);
    	}
    }
}
