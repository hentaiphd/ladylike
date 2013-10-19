package
{
    import org.flixel.*;
    import org.flixel.plugin.photonstorm.*;

    public class GroceryState extends FlxState{

        public var player:Player;
        public var food:Food;
        public var timeFrame:Number = 0;
        public var timeSec:Number = 0;
        public var awayText:FlxText;
        public var mousePoint:FlxObject;
        public var foodGroup:FlxGroup;
        public var foodText:FlxText;
        public var foodNames:Array;
        public var ranNum:int;
        public var nameFlag:Boolean;
        public var n:int = 0;

        override public function create():void{
            foodGroup = new FlxGroup();
            foodText = new FlxText(10,10,300,"Hello");
            foodText.color = 0xFFFFFFFF;
            add(foodText);
            nameFlag = false;

            var score:FlxText = new FlxText(10,20,200,n.toString());
            add(score);

            foodNames = new Array("Milk", "Eggs", "Water", "Bread", "Saltines", "Chicken",
                                    "a", "b", "c", "d", "e", "f",
                                    "g", "h", "i", "j", "k", "l",
                                    "m", "n");

            for(var i:int = 0; i < 20; i++){
                var ranX:Number = Math.random()*FlxG.width;
                var ranY:Number = Math.random()*FlxG.height;
                food = new Food(ranX,ranY);
                food.foodName = foodNames[i];
                food.foodNameText = new FlxText(ranX, ranY, 200, food.foodName);
                foodGroup.add(food);
                add(food);
                add(food.foodNameText);
            }

            mousePoint = new FlxObject(FlxG.mouse.x, FlxG.mouse.y);
            add(mousePoint);

            FlxG.mouse.show()

        }

        public function foodPush(food:Food, mouse:FlxObject):void{
            food.x = FlxG.mouse.x;
            food.y = FlxG.mouse.y;
        }

        public function foodTouch(food:Food, mouse:FlxObject):void{
            if(FlxG.mouse.justReleased()){
                if(food.foodName == foodText.text){
                    n++;
                }
            }
        }

        public function borderCollide(wallSprite:FlxSprite):void{
            if(wallSprite.x >= FlxG.width - wallSprite.width)
                wallSprite.x = FlxG.width - wallSprite.width;
            if(wallSprite.x <= 0)
                wallSprite.x = 0;
            if(wallSprite.y >= FlxG.height - wallSprite.height)
                wallSprite.y = FlxG.height - wallSprite.height;
            if(wallSprite.y <= 0)
                wallSprite.y = 0;
        }

        override public function update():void{
            super.update();
            mousePoint.x = FlxG.mouse.x;
            mousePoint.y = FlxG.mouse.y;
            FlxG.collide();
            borderCollide(food);
            FlxG.collide(food, mousePoint, foodPush);
            timeFrame++;

            if(timeFrame%100 == 0){
                timeSec++;
            }

            if(nameFlag == false){
                if(timeFrame%100 == 0){
                    nameFlag = true;
                    ranNum = Math.round(Math.random()*20);
                    foodText.text = foodNames[ranNum];
                }
            } else {
                nameFlag = false;
            }

            if(timeSec == 5){
                awayText.kill();
            }

            if(timeSec == 30){
                //FlxG.switchState(new DoorInState());
            }
        }
    }
}
