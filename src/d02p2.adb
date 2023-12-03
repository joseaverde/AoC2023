-- --- Part Two ---
--
-- The Elf says they've stopped producing snow because they aren't getting any
-- water! He isn't sure why the water stopped; however, he can show you how to
-- get to the water source to check it out for yourself. It's just up ahead!
--
-- As you continue your walk, the Elf poses a second question: in each game you
-- played, what is the fewest number of cubes of each color that could have
-- been in the bag to make the game possible?
--
-- Again consider the example games from earlier:
--
-- ```
-- Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
-- Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
-- Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
-- Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
-- Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
-- ```
--  - In game 1, the game could have been played with as few as 4 red, 2 green,
--    and 6 blue cubes. If any color had even one fewer cube, the game would
--    have been impossible.
--  - Game 2 could have been played with a minimum of 1 red, 3 green, and 4
--    blue cubes.
--  - Game 3 must have been played with at least 20 red, 13 green, and 6 blue
--    cubes.
--  - Game 4 required at least 14 red, 3 green, and 15 blue cubes.
--  - Game 5 needed no fewer than 6 red, 3 green, and 2 blue cubes in the bag.
--
-- The power of a set of cubes is equal to the numbers of red, green, and blue
-- cubes multiplied together. The power of the minimum set of cubes in game 1
-- is 48. In games 2-5 it was 12, 1560, 630, and 36, respectively. Adding up
-- these five powers produces the sum 2286.
--
-- For each game, find the minimum set of cubes that must have been present.
-- What is the sum of the power of these sets?

with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with AoC;                 use AoC;

procedure d02p2 is
   type Colour_Name is (Red, Green, Blue);
   type Colour_Array is array (Colour_Name) of Natural;
   Power    : Natural := 0;
   Items    : Colour_Array;
   Game_Id  : Positive with Unreferenced;
   Char     : Character;
   Buffer   : String (1 .. 32);
   Last     : Natural;
   EOL      : Boolean;
   Count    : Natural;
begin
   Default_Width := 1;
   Game_Loop : loop
      Skip (5); Read_Until (Buffer, Last, EOL, +":");
      Game_Id := Positive'Value (Buffer (Buffer'First .. Last));
      Items := (others => 0);
      Turn_Loop : loop
         Inner_Loop : loop
            Get (Count); Read_Until (Buffer, Last, EOL, +",;", False);
            Items (Colour_Name'Value (Buffer (Buffer'First .. Last)))
               := Natural'Max (@, Count);
            exit Inner_Loop when EOL;
            Get (Char);
            exit Inner_Loop when Char = ';';
         end loop Inner_Loop;
         exit Turn_Loop when EOL;
      end loop Turn_Loop;
      Power := Power + Items'Reduce ("*", 1);
      Skip_Line;
   end loop Game_Loop;
exception
   when End_Error =>
      Put (Power); New_Line;
end d02p2;
