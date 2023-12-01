-- --- Part Two --
--
-- Your calculation isn't quite right. It looks like some of the digits are
-- actually spelled out with letters: one, two, three, four, five, six, seven,
-- eight, and nine also count as valid "digits".
--
-- Equipped with this new information, you now need to find the real first and
-- last digit on each line. For example:
--
-- two1nine
-- eightwothree
-- abcone2threexyz
-- xtwone3four
-- 4nineeightseven2
-- zoneight234
-- 7pqrstsixteen
--
-- In this example, the calibration values are 29, 83, 13, 24, 42, 14, and 76.
-- Adding these together produces 281.
--
-- What is the sum of all of the calibration values?

with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with AoC;                 use AoC;

procedure d01p2 is
   use StrUnb;
   Zero  : constant := Character'Pos ('0');
   Items : constant UStr_Array (1 .. 9)
         := (+"one", +"two", +"three", +"four", +"five",
             +"six", +"seven", +"eight", +"nine");
   Sum   : Natural := 0;
   First : Natural;
   Last  : Natural;
begin
   Read_Loop : loop
      declare
         Line : constant String := Get_Line;
         Len  : Natural;
      begin
         exit Read_Loop when Line = "";
         Search_First : for I in Line'Range loop
            if Line (I) in '0' .. '9' then
               First := Character'Pos (Line (I)) - Zero;
               exit Search_First;
            end if;
            for J in Items'Range loop
               Len := Length (Items (J));
               if I + Len - 1 in Line'Range and then
                  Line (I .. I + Len - 1) = Items (J)
               then
                  First := J;
                  exit Search_First;
               end if;
            end loop;
         end loop Search_First;
         Search_Last : for I in reverse Line'Range loop
            if Line (I) in '0' .. '9' then
               Last := Character'Pos (Line (I)) - Zero;
               exit Search_Last;
            end if;
            for J in Items'Range loop
               Len := Length (Items (J));
               if I - Len + 1 in Line'Range and then
                  Line (I - Len + 1 .. I) = Items (J)
               then
                  Last := J;
                  exit Search_Last;
               end if;
            end loop;
         end loop Search_Last;
         Sum := Sum + First * 10 + Last;
      end;
   end loop Read_Loop;
   raise End_Error;
exception
   when End_Error =>
      Put (Sum, 1);
      New_Line;
end d01p2;
