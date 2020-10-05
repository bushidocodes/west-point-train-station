WITH Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO, TicketProgramPackage;
USE Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO, TicketProgramPackage;

PROCEDURE TicketProgram IS
    MenuChoice : Natural := 0;
    NewburgCost : CONSTANT Float := 3.50;
    NyackCost : CONSTANT Float := 5.25;
    NewburgSupply : Integer := 10;
    NyackSupply : Integer := 15;
    NumberTickets : Integer;
    TotalCost : Float := 0.00;
    AmountPaid :Float := 0.00;
    TotalChange : Float := 0.00;
    TotalProfit : Float := 0.00;

    PROCEDURE Newburg IS
    BEGIN
        Put("Purchase how many tickets to Newburg?");
        New_Line;
        Put(">");
        Get(NumberTickets);

        IF NewburgSupply - NumberTickets >= 0 AND NumberTickets > 0 THEN
            New_Line;
            Put("Sufficient Supply");

            TotalCost := NewburgCost * Float(NumberTickets);

            New_Line;
            Put("The total cost is > $");
            Put(TotalCost,Aft=>2,Exp=>0);
            New_Line;
            Put ("Enter amount paid");
            New_Line;
            Put("> $");
            Get(AmountPaid);

            TotalChange := AmountPaid - TotalCost;

            IF TotalChange >= 0.0 THEN
                Find_Change(TotalChange);
                NewburgSupply := NewburgSupply - NumberTickets;
                TotalProfit := TotalProfit + TotalCost;
            ELSE
                Put("Insufficient Payment: Transaction Terminated");
            END IF;
        ELSIF NumberTickets <= 0 THEN
            New_Line;
            Put("Invalid Input");
        ELSE
            New_Line;
            Put("Insufficient Supply");
            Check_Tickets(NewburgSupply,NyackSupply);
        END IF;
    END Newburg;

    PROCEDURE Nyack IS
    BEGIN
        Put("Purchase how many tickets to Nyack?");
        New_Line;
        Put(">");
        Get(NumberTickets);

        IF NyackSupply - NumberTickets >= 0 AND NumberTickets > 0 THEN
            New_Line;
            Put("Sufficient Supply");

            TotalCost := NyackCost * Float(NumberTickets);

            New_Line;
            Put("The total cost is > $");
            Put(TotalCost,Aft=>2,Exp=>0);
            New_Line;
            Put ("Enter amount paid");
            New_Line;
            Put("> $");
            Get(AmountPaid);

            TotalChange := AmountPaid - TotalCost;

            IF TotalChange >= 0.0 THEN
                Find_Change(TotalChange);
                NyackSupply := NyackSupply - NumberTickets;
                TotalProfit := TotalProfit + TotalCost;
            ELSE
                Put("Insufficient Payment: Transaction Terminated");
            END IF;

        ELSIF NumberTickets <= 0 THEN
            New_Line;
            Put("Invalid Input");
        ELSE
            New_Line;
            Put("Insufficient Supply");
            Check_Tickets(NewburgSupply,NyackSupply);
        END IF;

    END Nyack;

    PROCEDURE TrainDeparture IS

        TYPE Trains IS (nyack, newburg, quit, nothing);
        PACKAGE Trains_IO IS NEW Ada.Text_IO.Enumeration_IO(Enum=>Trains);
        SubmenuChoice : Trains := nothing;

    BEGIN

        WHILE SubmenuChoice /= quit
            Put("Train Departure Submenu:");
            New_Line;
            Put("Type 'newburg' to process Train Departure to Newburg");
            New_Line;
            Put("Type 'nyack' to process Train Departure to Nyack");
            New_Line;
            Put("Type 'quit' to return to Main Menu");
            New_Line;
            Put(">");

            Trains_IO.Get(SubmenuChoice);

            IF SubmenuChoice = newburg
            THEN
                NewburgSupply := 10;
            ELSIF SubmenuChoice = nyack
            THEN
                NyackSupply := 15;
            ELSIF SubmenuChoice = Quit
            THEN
                NULL;
            ELSE
                New_Line;
                Put("Invalid Input: Reenter");
                New_Line;
                New_Line;
            END IF;
        END ;
    END TrainDeparture;

BEGIN
    WHILE MenuChoice /= 6 LOOP
        New_Line;
        Put("Main Menu:");
        New_Line;
        Put("1)Sell Tickets to Newburg");
        New_Line;
        Put("2)Sell Tickets to Nyack");
        New_Line;
        Put("3)Process Train Departure");
        New_Line;
        Put("4)Check Tickets Remaining");
        New_Line;
        Put("5)View Total Sales");
        New_Line;
        Put("6)End Program");
        New_Line;
        Put(">");

        Get(MenuChoice);

        IF MenuChoice = 1
        THEN
            New_Line;
            Newburg;
            New_Line;
        ELSIF MenuChoice = 2
        THEN
            New_Line;
            Nyack;
            New_Line;
        ELSIF MenuChoice = 3
        THEN
            New_Line;
            TrainDeparture;
            New_Line;
        ELSIF MenuChoice = 4
        THEN
            New_Line;
            Check_Tickets(NewburgSupply,NyackSupply);
            New_Line;
        ELSIF MenuChoice = 5
        THEN
            New_Line;
            View_Total_Sales(TotalProfit);
            New_Line;
        END IF;
    END ;

END TicketProgram;

PACKAGE TicketProgramPackage IS

    PROCEDURE View_Total_Sales (TotalProfit : IN Float);
    --Pre: Inputs Total Profit
    --Post: Outputs the total profit to the user

    PROCEDURE Check_Tickets (NewburgSupply : IN Integer; NyackSupply : IN Integer);
    --Pre: Input Integer values of the number of Newburg and Nyack tickets available
    --Post: Lists out the tickets available

    PROCEDURE Find_Change (TotalChange : IN Float);
    --Pre: Input amount of change
    --Post: Outputs the number of each increment of change that must be returned

END TicketProgramPackage;

WITH Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;
USE Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;

PACKAGE BODY TicketProgramPackage IS

    PROCEDURE View_Total_Sales (TotalProfit : IN Float) IS
    BEGIN
        New_Line;
        Put("The total of sales is \$");
        Put(TotalProfit,Aft=>2,Exp=>0);
    END View_Total_Sales;

    PROCEDURE Check_Tickets (NewburgSupply : IN Integer; NyackSupply : IN Integer) IS
        Counter : Integer;
    BEGIN
        New_Line;
        Counter := 1;
        Put("Ticket Inventory:");
        New_Line;
        
        WHILE NewburgSupply - Counter >= 0 LOOP
            Put(Counter);
            Put(" Newburg Ticket");
            New_Line;
            Counter := Counter +1;
        END ;
        
        New_Line;
        Counter := 1;

        FOR Count IN 1..NyackSupply LOOP
            Put(Count);
            Put(" Nyack Ticket");
            New_Line;
        END ;

    END Check_Tickets;

    PROCEDURE Find_Change (TotalChange: IN Float) IS
        TotalChangeHundred : Float;
        TotalChangeInteger : Integer;
        NumberDollars : Integer;
        NumberQuarters : Integer;
        NumberDimes : Integer;
        NumberNickels : Integer;
        NumberPennies : Integer;

        FUNCTION Find_Number_Coins(Value,Amount:Integer)RETURN Integer IS
            Number : Natural := 0;
            Amount_Internal : Integer;
        BEGIN
            Amount_Internal := Amount;

            WHILE Value <= Amount_Internal
                Number := Number + 1;
                Amount_Internal := Amount_Internal - Value;
            END ;

            RETURN Number;
        END Find_Number_Coins;

    BEGIN

        --Initialize variable;
        NumberDollars := 0;
        NumberQuarters := 0;
        NumberDimes := 0;
        NumberNickels := 0;
        NumberPennies := 0;

        --convert TotalChange to TotalChangeInteger
        TotalChangeHundred := TotalChange \* 100.0;
        TotalChangeInteger := Integer(TotalChangeHundred);

        --calculate amount of dollars needed]
        NumberDollars := Find_Number_Coins(100,TotalChangeInteger);
        TotalChangeInteger := TotalChangeInteger - (NumberDollars \* 100);

        NumberQuarters := Find_Number_Coins(25,TotalChangeInteger);
        TotalChangeInteger := TotalChangeInteger - (NumberQuarters \* 25);

        NumberDimes := Find_Number_Coins(10,TotalChangeInteger);
        TotalChangeInteger := TotalChangeInteger - (NumberDimes \* 10);

        NumberNickels := Find_Number_Coins(5,TotalChangeInteger);
        TotalChangeInteger := TotalChangeInteger - (NumberNickels \* 5);

        NumberPennies := Find_Number_Coins(1,TotalChangeInteger);
        TotalChangeInteger := TotalChangeInteger - (NumberPennies \* 1);

        --Output Results
        New_Line;
        Put("Give the customer ");
        Put(NumberDollars);
        Put(" Dollars");

        New_Line;
        Put("Give the customer ");
        Put (NumberQuarters);
        Put(" Quarters");

        New_Line;
        Put("Give the customer ");
        Put (NumberDimes);
        Put(" Dimes");

        New_Line;
        Put("Give the customer ");
        Put (NumberNickels);
        Put(" Nickels");

        New_Line;
        Put("Give the customer ");
        Put (NumberPennies);
        Put (" Pennies");

    END Find_Change;

End TicketProgramPackage;
