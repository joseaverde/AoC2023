with Ada.Strings.Unbounded;
with Ada.Strings.Maps;

package AoC is

   package StrUnb renames Ada.Strings.Unbounded;
   package StrMap renames Ada.Strings.Maps;

   subtype UStr is StrUnb.Unbounded_String;
   subtype SSet is StrMap.Character_Set;

   type UStr_Array is array (Positive range <>) of UStr;

   Empty_UStr renames StrUnb.Null_Unbounded_String;

   type SMat is array (Positive range <>, Positive range <>) of Character;

   Empty_SMat : constant SMat (1 .. 0, 1 .. 0) := (others => (others => ' '));

   function "+" (Right : in String)
      return UStr
      renames StrUnb.To_Unbounded_String;

   function "-" (Right : in UStr)
      return String
      renames StrUnb.To_String;

   function "+" (Right : in String)
      return SSet
      renames StrMap.To_Set;

   procedure Read_Until (
      Item :    out String;
      Last :    out Natural;
      EOL  :    out Boolean;
      Stop : in     SSet;
      Skip : in     Boolean := True);

   procedure Skip (Item : in SSet);

   procedure Skip (Count : Positive);

   overriding
   function "&" (Left, Right : in SMat) return SMat with
      Pre      => Left'Length (2) = Right'Length (2)
         and then Left'First (2) = Right'First (2),
      Post     => "&"'Result'Length (1) = Left'Length (1) + Right'Length (2)
         and then "&"'Result'Length (2) = Left'Length (2)
         and then "&"'Result'First (1) = Left'First (1),
      Global   => null;

   function Read return SMat with
      Post => Read'Result'First (1) = 1 and then Read'Result'First (2) = 1;

end AoC;
