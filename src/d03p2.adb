-- --- Part Two ---
--
-- The engineer finds the missing part and installs it in the engine! As the
-- engine springs to life, you jump in the closest gondola, finally ready to
-- ascend to the water source.
--
-- You don't seem to be going very fast, though. Maybe something is still
-- wrong? Fortunately, the gondola has a phone labeled "help", so you pick it
-- up and the engineer answers.
--
-- Before you can explain the situation, she suggests that you look out the
-- window. There stands the engineer, holding a phone in one hand and waving
-- with the other. You're going so slowly that you haven't even left the
-- station. You exit the gondola.
--
-- The missing part wasn't the only issue - one of the gears in the engine is
-- wrong. A gear is any * symbol that is adjacent to exactly two part numbers.
-- Its gear ratio is the result of multiplying those two numbers together.
--
-- This time, you need to find the gear ratio of every gear and add them all up
-- so that the engineer can figure out which gear needs to be replaced.
--
-- Consider the same engine schematic again:
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
-- In this schematic, there are two gears. The first is in the top left; it has
-- part numbers 467 and 35, so its gear ratio is 16345. The second gear is in
-- the lower right; its gear ratio is 451490. (The * adjacent to 617 is not a
-- gear because it is only adjacent to one part number.) Adding up all of the
-- gear ratios produces 467835.
--
-- What is the sum of all of the gear ratios in your engine schematic?

with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with AoC;                 use AoC;

procedure d03p2 is
   subtype Digit is Character range '0' .. '9';
   Map   : constant SMat := Read;
   Gears : Natural := 0;
   Dirs  : constant array (0 .. 8) of Integer := (-1, -1, 0, -1, 1, 0, 1, 1, -1);
   CnvtT : constant array (1 .. 8) of Integer := (1, 2, 4, 3, 8, 6, 9, 7);
   CnvtF : constant array (1 .. 9) of Integer := (1, 2, 4, 3, 0, 6, 8, 5, 7);

   Valid : array (1 .. 8) of Boolean := (others => False);

   function Find (Row, Col, Item : in Natural) return Integer is
      I : Natural := 0;
      R : Natural;
      C : Natural;
      L : Natural := 0;
   begin
      for V in Valid'Range when Valid (V) loop
         I := I + 1;
         if I = Item then
            R := Dirs (V - 1) + Row;
            C := Dirs (V) + Col;
            exit;
         end if;
      end loop;

      L := C;
      while C - 1 in Map'Range (2) and then Map (R, C - 1) in Digit loop
         C := C - 1;
      end loop;
      while L + 1 in Map'Range (2) and then Map (R, L + 1) in Digit loop
         L := L + 1;
      end loop;

      return Integer'Value ([for I in C .. L => Map (R, I)]);
   end Find;
begin
   Default_Width := 1;
   for Row in Map'Range (1) loop
      for Col in Map'Range (2) when Map (Row, Col) = '*' loop
         Valid := [for D in 1 .. 8 =>
                     Row + Dirs (D - 1) in Map'Range (1) and then
                     Col + Dirs (D)     in Map'Range (2) and then
                     Map (Row + Dirs (D - 1), Col + Dirs (D)) in Digit];
         Valid := [for I in Valid'Range =>
                     (case CnvtT (I) is
                        when 2 .. 3 | 8 .. 9 =>
                           not Valid (CnvtF (CnvtT (I) - 1)) and then Valid (I),
                        when others => Valid (I))];
         if [for I of Valid => (if I then 1 else 0)] 'Reduce ("+", 0) = 2 then
            Gears := Gears + Find (Row, Col, 1) * Find (Row, Col, 2);
         end if;
      end loop;
   end loop;
   Put (Gears); New_Line;
end d03p2;
