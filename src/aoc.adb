with Ada.Text_IO;

package body AoC is

   procedure Skip (Count : Positive) is
      use Ada.Text_IO;
      Char : Character;
   begin
      for I in 1 .. Count loop
         Get (Char);
      end loop;
   end Skip;

   procedure Read_Until (
      Item :    out String;
      Last :    out Natural;
      EOL  :    out Boolean;
      Stop : in     SSet;
      Skip : in     Boolean := True)
   is
      use Ada.Text_IO;
      Char : Character;
   begin
      Last := Item'First - 1;
      loop
         Look_Ahead (Char, EOL);
         exit when EOL or else StrMap.Is_In (Char, Stop);
         Last := Last + 1;
         Item (Last) := Char;
         Get (Char);
      end loop;
      if not EOL and then Skip then
         Get (Char);
      end if;
   end Read_Until;

end AoC;
