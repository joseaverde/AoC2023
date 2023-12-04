with Ada.Text_IO;

package body AoC is

   procedure Skip (Item : in SSet) is
      use Ada.Text_IO;
      Char : Character;
      EOL  : Boolean;
   begin
      loop
         Look_Ahead (Char, EOL);
         exit when EOL or else not StrMap.Is_In (Char, Item);
         Get (Char);
      end loop;
   end Skip;

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

   overriding
   function "&" (Left, Right : in SMat) return SMat is
   begin
      return Result : SMat (Left'First (1) .. Left'First (1) - 1
                                          + Left'Length (1) + Right'Length (1),
                            Left'Range (2))
      do
         for I in Left'Range (1) loop
            for J in Left'Range (2) loop
               Result (I, J) := Left (I, J);
            end loop;
         end loop;
         for I in Left'Last (1) + 1 .. Left'Last (1) + Right'Length (1) loop
            for J in Right'Range (2) loop
               Result (I, J)
                  := Right (I - Left'Last (1) - 1 + Right'First (1), J);
            end loop;
         end loop;
      end return;
   end "&";

   function Read return SMat is
      use Ada.Text_IO;
      function Rec_Read (Line : in String) return SMat is
         Result : constant SMat (1 .. 1, 1 .. Line'Length) :=
            [[for I in 1 .. Line'Length => Line (Line'First + I - 1)]];
      begin
         declare
            Next : constant String := Get_Line;
         begin
            return (if Next'Length /= Line'Length then Result
                     else Result & Rec_Read (Next));
         end;
      exception
         when End_Error =>
            return Result;
      end Rec_Read;
      Line : constant String := Get_Line;
   begin
      return (if Line'Length = 0 then Empty_SMat else Rec_Read (Line));
   exception
      when End_Error => return Empty_SMat;
   end Read;

end AoC;
