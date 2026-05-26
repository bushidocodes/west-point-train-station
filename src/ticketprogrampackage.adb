with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

package body TicketProgramPackage is

    procedure View_Total_Sales (TotalProfit : in Money) is
    begin
        New_Line;
        Put ("The total of sales is \$");
        Money_IO.Put (TotalProfit, Fore => 1, Aft => 2, Exp => 0);
    end View_Total_Sales;

    procedure Check_Tickets
       (NewburgSupply : in Integer; NyackSupply : in Integer)
    is
    begin
        New_Line;
        Put ("Ticket Inventory:");
        New_Line;

        for Count in 1 .. NewburgSupply loop
            Put (Count);
            Put (" Newburg Ticket");
            New_Line;
        end loop;

        New_Line;

        for Count in 1 .. NyackSupply loop
            Put (Count);
            Put (" Nyack Ticket");
            New_Line;
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

        --Initialize variable;
        NumberDollars  := 0;
        NumberQuarters := 0;
        NumberDimes    := 0;
        NumberNickels  := 0;
        NumberPennies  := 0;

        TotalChangeInteger := Integer (TotalChange * 100);

        --calculate amount of dollars needed]
        NumberDollars      := Find_Number_Coins (100, TotalChangeInteger);
        TotalChangeInteger := TotalChangeInteger - (NumberDollars * 100);

        NumberQuarters     := Find_Number_Coins (25, TotalChangeInteger);
        TotalChangeInteger := TotalChangeInteger - (NumberQuarters * 25);

        NumberDimes        := Find_Number_Coins (10, TotalChangeInteger);
        TotalChangeInteger := TotalChangeInteger - (NumberDimes * 10);

        NumberNickels      := Find_Number_Coins (5, TotalChangeInteger);
        TotalChangeInteger := TotalChangeInteger - (NumberNickels * 5);

        NumberPennies      := Find_Number_Coins (1, TotalChangeInteger);
        TotalChangeInteger := TotalChangeInteger - (NumberPennies * 1);

        --Output Results
        New_Line;
        Put ("Give the customer ");
        Put (NumberDollars);
        Put (" Dollars");

        New_Line;
        Put ("Give the customer ");
        Put (NumberQuarters);
        Put (" Quarters");

        New_Line;
        Put ("Give the customer ");
        Put (NumberDimes);
        Put (" Dimes");

        New_Line;
        Put ("Give the customer ");
        Put (NumberNickels);
        Put (" Nickels");

        New_Line;
        Put ("Give the customer ");
        Put (NumberPennies);
        Put (" Pennies");

    end Find_Change;

end TicketProgramPackage;
