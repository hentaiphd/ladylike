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
            zero.addResponse("END // Enter to restart\nxoxo Nina, Emmett, David, Winnie", "RESTART");
            convoTree[0] = zero;

            return convoTree;
        }
    }
}
