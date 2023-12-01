with Ada.Strings.Unbounded;

package AoC is

   package StrUnb renames Ada.Strings.Unbounded;

   subtype UStr is StrUnb.Unbounded_String;

   type UStr_Array is array (Positive range <>) of UStr;

   Empty_UStr renames StrUnb.Null_Unbounded_String;

   function "+" (Right : in String)
      return UStr
      renames StrUnb.To_Unbounded_String;

   function "-" (Right : in UStr)
      return String
      renames StrUnb.To_String;

end AoC;
