-- --- Day 3: Gear Ratios ---
--
-- You and the Elf eventually reach a gondola lift station; he says the gondola
-- lift will take you up to the water source, but this is as far as he can
-- bring you. You go inside.
--
-- It doesn't take long to find the gondolas, but there seems to be a problem:
-- they're not moving.
--
-- "Aaah!"
--
-- You turn around to see a slightly-greasy Elf with a wrench and a look of
-- surprise. "Sorry, I wasn't expecting anyone! The gondola lift isn't working
-- right now; it'll still be a while before I can fix it." You offer to help.
--
-- The engineer explains that an engine part seems to be missing from the
-- engine, but nobody can figure out which one. If you can add up all the part
-- numbers in the engine schematic, it should be easy to work out which part is
-- missing.
--
-- The engine schematic (your puzzle input) consists of a visual representation
-- of the engine. There are lots of numbers and symbols you don't really
-- understand, but apparently any number adjacent to a symbol, even diagonally,
-- is a "part number" and should be included in your sum. (Periods (.) do not
-- count as a symbol.)
--
-- Here is an example engine schematic:
--
-- ```
-- 467..114..
-- ...*......
-- ..35..633.
-- ......#...
-- 617*......
-- .....+.58.
-- ..592.....
-- ......755.
-- ...$.*....
-- .664.598..
-- ```
--
-- In this schematic, two numbers are not part numbers because they are not
-- adjacent to a symbol: 114 (top right) and 58 (middle right). Every other
-- number is adjacent to a symbol and so is a part number; their sum is 4361.
--
-- Of course, the actual engine schematic is much larger. What is the sum of
-- all of the part numbers in the engine schematic?
--
-- To play, please identify yourself via one of these services:

with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with AoC;                 use AoC;

procedure d03p1 is
   Map   : constant SMat := Read;
   Last  : Natural;
   Row   : Natural := Map'First (1);
   Col   : Natural;
   Num   : Natural;
   Valid : Boolean;
   Count : Natural := 0;
begin
   Default_Width := 1;
   while Row in Map'Range (1) loop
      Col := Map'First (2);
      while Col in Map'Range (2) loop
         if Map (Row, Col) in '0' .. '9' then
            Last := Col;
            while Last in Map'Range (2) and then Map (Row, Last) in '0' .. '9'
               loop Last := Last + 1;
            end loop;
            Last := Last - 1;
            Num := Natural'Value ([for I in Col .. Last => Map (Row, I)]);
            Valid := False;
            Adjacent : for R in Natural'Max (Map'First (1), Row - 1) ..
                                Natural'Min (Map'Last (1), Row + 1)
            loop
               for C in Natural'Max (Map'First (2), Col - 1) ..
                        Natural'Min (Map'Last (2), Last + 1)
               loop
                  Valid := Map (R, C) not in '0' .. '9' | '.';
                  exit Adjacent when Valid;
               end loop;
            end loop Adjacent;
            Count := @ + (if Valid then Num else 0);
            Col := Last;
         end if;
         Col := Col + 1;
      end loop;
      Row := Row + 1;
   end loop;
   Put (Count); New_Line;
end d03p1;
