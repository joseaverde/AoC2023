with Ada.Strings.Unbounded;
with Ada.Strings.Maps;

package AoC is

   package StrUnb renames Ada.Strings.Unbounded;
   package StrMap renames Ada.Strings.Maps;

   subtype UStr is StrUnb.Unbounded_String;
   subtype SSet is StrMap.Character_Set;

   type UStr_Array is array (Positive range <>) of UStr;

   Empty_UStr renames StrUnb.Null_Unbounded_String;

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

   procedure Skip (Count : Positive);

end AoC;
