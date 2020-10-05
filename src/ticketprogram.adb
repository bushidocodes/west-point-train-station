with Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO, TicketProgramPackage;
use Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO, TicketProgramPackage;

procedure TicketProgram is
    MenuChoice    : Natural        := 0;
    NewburgCost   : constant Float := 3.50;
    NyackCost     : constant Float := 5.25;
    NewburgSupply : Integer        := 10;
    NyackSupply   : Integer        := 15;
    NumberTickets : Integer;
    TotalCost     : Float          := 0.00;
    AmountPaid    : Float          := 0.00;
    TotalChange   : Float          := 0.00;
    TotalProfit   : Float          := 0.00;

    procedure Newburg is
    begin
        Put ("Purchase how many tickets to Newburg?");
        New_Line;
        Put (">");
        Get (NumberTickets);

        if NewburgSupply - NumberTickets >= 0 and NumberTickets > 0 then
            New_Line;
            Put ("Sufficient Supply");

            TotalCost := NewburgCost * Float (NumberTickets);

            New_Line;
            Put ("The total cost is > $");
            Put (TotalCost, Aft => 2, Exp => 0);
            New_Line;
            Put ("Enter amount paid");
            New_Line;
            Put ("> $");
            Get (AmountPaid);

            TotalChange := AmountPaid - TotalCost;

            if TotalChange >= 0.0 then
                Find_Change (TotalChange);
                NewburgSupply := NewburgSupply - NumberTickets;
                TotalProfit   := TotalProfit + TotalCost;
            else
                Put ("Insufficient Payment: Transaction Terminated");
            end if;
        elsif NumberTickets <= 0 then
            New_Line;
            Put ("Invalid Input");
        else
            New_Line;
            Put ("Insufficient Supply");
            Check_Tickets (NewburgSupply, NyackSupply);
        end if;
    end Newburg;

    procedure Nyack is
    begin
        Put ("Purchase how many tickets to Nyack?");
        New_Line;
        Put (">");
        Get (NumberTickets);

        if NyackSupply - NumberTickets >= 0 and NumberTickets > 0 then
            New_Line;
            Put ("Sufficient Supply");

            TotalCost := NyackCost * Float (NumberTickets);

            New_Line;
            Put ("The total cost is > $");
            Put (TotalCost, Aft => 2, Exp => 0);
            New_Line;
            Put ("Enter amount paid");
            New_Line;
            Put ("> $");
            Get (AmountPaid);

            TotalChange := AmountPaid - TotalCost;

            if TotalChange >= 0.0 then
                Find_Change (TotalChange);
                NyackSupply := NyackSupply - NumberTickets;
                TotalProfit := TotalProfit + TotalCost;
            else
                Put ("Insufficient Payment: Transaction Terminated");
            end if;

        elsif NumberTickets <= 0 then
            New_Line;
            Put ("Invalid Input");
        else
            New_Line;
            Put ("Insufficient Supply");
            Check_Tickets (NewburgSupply, NyackSupply);
        end if;

    end Nyack;

    procedure TrainDeparture is

        type Trains is (nyack, newburg, quit, nothing);
        package Trains_IO is new Ada.Text_IO.Enumeration_IO (Enum => Trains);
        SubmenuChoice : Trains := nothing;

    begin

        while SubmenuChoice /= quit loop
            Put ("Train Departure Submenu:");
            New_Line;
            Put ("Type 'newburg' to process Train Departure to Newburg");
            New_Line;
            Put ("Type 'nyack' to process Train Departure to Nyack");
            New_Line;
            Put ("Type 'quit' to return to Main Menu");
            New_Line;
            Put (">");

            Trains_IO.Get (SubmenuChoice);

            if SubmenuChoice = newburg then
                NewburgSupply := 10;
            elsif SubmenuChoice = nyack then
                NyackSupply := 15;
            elsif SubmenuChoice = quit then
                null;
            else
                New_Line;
                Put ("Invalid Input: Reenter");
                New_Line;
                New_Line;
            end if;
        end loop;
    end TrainDeparture;

begin
    while MenuChoice /= 6 loop
        New_Line;
        Put ("Main Menu:");
        New_Line;
        Put ("1)Sell Tickets to Newburg");
        New_Line;
        Put ("2)Sell Tickets to Nyack");
        New_Line;
        Put ("3)Process Train Departure");
        New_Line;
        Put ("4)Check Tickets Remaining");
        New_Line;
        Put ("5)View Total Sales");
        New_Line;
        Put ("6)End Program");
        New_Line;
        Put (">");

        Get (MenuChoice);

        if MenuChoice = 1 then
            New_Line;
            Newburg;
            New_Line;
        elsif MenuChoice = 2 then
            New_Line;
            Nyack;
            New_Line;
        elsif MenuChoice = 3 then
            New_Line;
            TrainDeparture;
            New_Line;
        elsif MenuChoice = 4 then
            New_Line;
            Check_Tickets (NewburgSupply, NyackSupply);
            New_Line;
        elsif MenuChoice = 5 then
            New_Line;
            View_Total_Sales (TotalProfit);
            New_Line;
        end if;
    end loop;

end TicketProgram;
