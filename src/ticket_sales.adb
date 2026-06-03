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

        declare
            Count : Natural := 1;
        begin
            while Count <= NyackSupply loop
                Put_Line (Count'Image & " Nyack Ticket");
                Count := Count + 1;
            end loop;
        end;

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
    begin
        if TotalChange = 0.00 then
            Put_Line ("Exact price paid.");
            return;
        end if;
        declare
            C : constant Change_Breakdown := Calculate_Change (TotalChange);
        begin
            if C.Dollars  > 0 then Put_Line ("Give the customer" & C.Dollars'Image  & " Dollars");  end if;
            if C.Quarters > 0 then Put_Line ("Give the customer" & C.Quarters'Image & " Quarters"); end if;
            if C.Dimes    > 0 then Put_Line ("Give the customer" & C.Dimes'Image    & " Dimes");    end if;
            if C.Nickels  > 0 then Put_Line ("Give the customer" & C.Nickels'Image  & " Nickels");  end if;
            if C.Pennies  > 0 then Put_Line ("Give the customer" & C.Pennies'Image  & " Pennies");  end if;
        end;
    end Find_Change;

end Ticket_Sales;
