with Ada.Text_IO;
use Ada.Text_IO;

package body TicketProgramPackage is

    procedure View_Total_Sales (TotalProfit : in Money) is
    begin
        New_Line;
        Put ("The total of sales is \$");
        Money_IO.Put (TotalProfit, Fore => 1, Aft => 2, Exp => 0);
    end View_Total_Sales;

    procedure Check_Tickets
       (NewburgSupply : in Natural; NyackSupply : in Natural)
    is
    begin
        New_Line;
        Put_Line ("Ticket Inventory:");

        for Count in 1 .. NewburgSupply loop
            Put_Line (Count'Image & " Newburg Ticket");
        end loop;

        New_Line;

        for Count in 1 .. NyackSupply loop
            Put_Line (Count'Image & " Nyack Ticket");
        end loop;

    end Check_Tickets;

    procedure Find_Change (TotalChange : in Money) is
        TotalChangeInteger : Natural;
        NumberDollars      : Natural;
        NumberQuarters     : Natural;
        NumberDimes        : Natural;
        NumberNickels      : Natural;
        NumberPennies      : Natural;

        function Find_Number_Coins (Value, Amount : Integer) return Integer is
           (Amount / Value);

    begin

        NumberDollars  := 0;
        NumberQuarters := 0;
        NumberDimes    := 0;
        NumberNickels  := 0;
        NumberPennies  := 0;

        TotalChangeInteger := Integer (TotalChange * 100);

        NumberDollars      := Find_Number_Coins (100, TotalChangeInteger);
        TotalChangeInteger := TotalChangeInteger - (NumberDollars * 100);

        NumberQuarters     := Find_Number_Coins (25, TotalChangeInteger);
        TotalChangeInteger := TotalChangeInteger - (NumberQuarters * 25);

        NumberDimes        := Find_Number_Coins (10, TotalChangeInteger);
        TotalChangeInteger := TotalChangeInteger - (NumberDimes * 10);

        NumberNickels      := Find_Number_Coins (5, TotalChangeInteger);
        TotalChangeInteger := TotalChangeInteger - (NumberNickels * 5);

        NumberPennies      := Find_Number_Coins (1, TotalChangeInteger);

        New_Line;
        Put_Line ("Give the customer" & NumberDollars'Image  & " Dollars");
        Put_Line ("Give the customer" & NumberQuarters'Image & " Quarters");
        Put_Line ("Give the customer" & NumberDimes'Image    & " Dimes");
        Put_Line ("Give the customer" & NumberNickels'Image  & " Nickels");
        Put_Line ("Give the customer" & NumberPennies'Image  & " Pennies");

    end Find_Change;

end TicketProgramPackage;
