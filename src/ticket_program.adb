with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Strings.Unbounded, Ticket_Sales;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Strings.Unbounded, Ticket_Sales;

procedure Ticket_Program is

    type Destination is record
        Name           : Unbounded_String;
        Cost           : Money;
        Supply         : Natural;
        Initial_Supply : Natural;
    end record;

    MenuChoice    : Natural := 0;
    NumberTickets : Integer;
    TotalCost     : Money   := 0.00;
    AmountPaid    : Money   := 0.00;
    TotalChange   : Money   := 0.00;
    TotalProfit   : Money   := 0.00;

    Newburg_Route : Destination :=
       (Name           => To_Unbounded_String ("Newburg"),
        Cost           => 3.50,
        Supply         => 10,
        Initial_Supply => 10);

    Nyack_Route : Destination :=
       (Name           => To_Unbounded_String ("Nyack"),
        Cost           => 5.25,
        Supply         => 15,
        Initial_Supply => 15);

    procedure Sell_Tickets (Dest : in out Destination) is
    begin
        Put_Line ("Purchase how many tickets to " & To_String (Dest.Name) & "?");
        Put (">");
        Get (NumberTickets);
        New_Line;

        if Dest.Supply - NumberTickets >= 0 and then NumberTickets > 0 then
            Put_Line ("Sufficient Supply");

            TotalCost := Dest.Cost * NumberTickets;

            Put ("The total cost is > $");
            Money_IO.Put (TotalCost, Fore => 1, Aft => 2, Exp => 0);
            New_Line;
            Put_Line ("Enter amount paid");
            Put ("> $");
            Money_IO.Get (AmountPaid);

            TotalChange := AmountPaid - TotalCost;

            if TotalChange >= 0.0 then
                Find_Change (TotalChange);
                Dest.Supply := Dest.Supply - NumberTickets;
                TotalProfit := TotalProfit + TotalCost;
            else
                Put ("Insufficient Payment: Transaction Terminated");
            end if;
        elsif NumberTickets <= 0 then
            Put ("Invalid Input");
        else
            Put ("Insufficient Supply");
            Check_Tickets (Newburg_Route.Supply, Nyack_Route.Supply);
        end if;
    end Sell_Tickets;

    procedure TrainDeparture is

        type Trains is (nyack, newburg, quit, nothing);
        package Trains_IO is new Ada.Text_IO.Enumeration_IO (Enum => Trains);
        SubmenuChoice : Trains := nothing;

    begin

        while SubmenuChoice /= quit loop
            Put_Line ("Train Departure Submenu:");
            Put_Line ("Type 'newburg' to process Train Departure to Newburg");
            Put_Line ("Type 'nyack' to process Train Departure to Nyack");
            Put_Line ("Type 'quit' to return to Main Menu");
            Put (">");

            begin
                Trains_IO.Get (SubmenuChoice);
            exception
                when Data_Error =>
                    Skip_Line;
                    SubmenuChoice := nothing;
            end;

            case SubmenuChoice is
                when newburg =>
                    Newburg_Route.Supply := Newburg_Route.Initial_Supply;
                when nyack =>
                    Nyack_Route.Supply := Nyack_Route.Initial_Supply;
                when quit =>
                    null;
                when nothing =>
                    New_Line;
                    Put_Line ("Invalid Input: Reenter");
            end case;
        end loop;
    end TrainDeparture;

begin
    while MenuChoice /= 6 loop
        New_Line;
        Put_Line ("Main Menu:");
        Put_Line ("1)Sell Tickets to Newburg");
        Put_Line ("2)Sell Tickets to Nyack");
        Put_Line ("3)Process Train Departure");
        Put_Line ("4)Check Tickets Remaining");
        Put_Line ("5)View Total Sales");
        Put_Line ("6)End Program");
        Put (">");

        Get (MenuChoice);

        case MenuChoice is
            when 1 =>
                Sell_Tickets (Newburg_Route);
            when 2 =>
                Sell_Tickets (Nyack_Route);
            when 3 =>
                TrainDeparture;
            when 4 =>
                Check_Tickets (Newburg_Route.Supply, Nyack_Route.Supply);
            when 5 =>
                View_Total_Sales (TotalProfit);
            when 6 =>
                null;
            when others =>
                Put_Line ("Invalid Input: Please enter 1-6");
        end case;
    end loop;

end Ticket_Program;
