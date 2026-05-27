with Ada.Text_IO;
use Ada.Text_IO;

package body Ticket_Sales is

    procedure View_Total_Sales (TotalProfit : in Money) is
    begin
        Put ("The total of sales is $");
        Money_IO.Put (TotalProfit, Fore => 1, Aft => 2, Exp => 0);
        New_Line;
    end View_Total_Sales;

    procedure Check_Tickets
       (NewburgSupply : in Natural; NyackSupply : in Natural)
    is
    begin
        Put_Line ("Ticket Inventory:");

        for Count in 1 .. NewburgSupply loop
            Put_Line (Count'Image & " Newburg Ticket");
        end loop;

        New_Line;

        for Count in 1 .. NyackSupply loop
            Put_Line (Count'Image & " Nyack Ticket");
        end loop;

    end Check_Tickets;

    function Calculate_Change (Amount : Money) return Change_Breakdown is
        Remaining : Natural := Natural (Amount * 100);
        Result    : Change_Breakdown;
    begin
        Result.Dollars  := Remaining / 100; Remaining := Remaining mod 100;
        Result.Quarters := Remaining / 25;  Remaining := Remaining mod 25;
        Result.Dimes    := Remaining / 10;  Remaining := Remaining mod 10;
        Result.Nickels  := Remaining / 5;   Remaining := Remaining mod 5;
        Result.Pennies  := Remaining;
        return Result;
    end Calculate_Change;

    procedure Find_Change (TotalChange : in Money) is
        C : constant Change_Breakdown := Calculate_Change (TotalChange);
    begin
        Put_Line ("Give the customer" & C.Dollars'Image  & " Dollars");
        Put_Line ("Give the customer" & C.Quarters'Image & " Quarters");
        Put_Line ("Give the customer" & C.Dimes'Image    & " Dimes");
        Put_Line ("Give the customer" & C.Nickels'Image  & " Nickels");
        Put_Line ("Give the customer" & C.Pennies'Image  & " Pennies");
    end Find_Change;

end Ticket_Sales;
