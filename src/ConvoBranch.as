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
