-- BTW: I'm too lazy to figure out compiling/running programs locally, so unless 
-- it doesn't exist, I will be using online compilers to run my solution

-- Some parts of Ada is kinda interesting, there's some influence from 
-- functional programs in the sense that defining types is super easy
-- and I can see why its useful (making typed restrictions is super simple, 
-- literally just 1 .. 100) and that functions *shouldn't* have side-effects
-- Overall though, I don't really like writing code in Ada. Defining 
-- variables, and the overall structure of the program doesn't free super 
-- natural (functions / procedures). Maybe if I wrote more code I would like 
-- it more though, not sure. 

-- https://onecompiler.com/ada

with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Ada.Containers.Vectors;

procedure Main is
   package LocationID_List is new Ada.Containers.Vectors
     (Index_Type   => Natural,
      Element_Type => Integer);

   package LocationID_Sorter is new LocationID_List.Generic_Sorting;

   L1 : LocationID_List.Vector;
   L2 : LocationID_List.Vector;

   First, Second : Integer;
   Part1 : Integer := 0;
   Part2 : Integer := 0;

   -- Could be done using a frequency map, but the syntax seemed kinda hard
   -- and I got lazy, also I couldn't seem to find a Count function for 
   -- Ada.Containers.Vectors, so I wrote my own. 
   function Count (V : LocationID_List.Vector; Element : Integer) return Natural is
      Count : Natural := 0;
   begin
      for I in V.First_Index .. V.Last_Index loop
         if V.Element(I) = Element then
            Count := Count + 1;
         end if;
      end loop;
      return Count;
   end Count;

begin
   -- read input
   while not End_Of_File loop
      Get(First);
      Get(Second);

      L1.Append(First);
      L2.Append(Second);
   end loop;

   LocationID_Sorter.Sort(L1);
   LocationID_Sorter.Sort(L2);

   -- sum of differences
   for I in L1.First_Index .. L1.Last_Index loop
      Part1 := Part1 + Abs(L1.Element(I) - L2.Element(I));
   end loop;

   -- print part 1
   Put_Line("Part1: " & Integer'Image(Part1));

   -- print part 2
   for I in L1.First_Index .. L1.Last_Index loop
      Part2 := Part2 + L1.Element(I) * Count(L2, L1.Element(I));
   end loop;

   Put_Line("Part2: " & Integer'Image(Part2));

end Main;