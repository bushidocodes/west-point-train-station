with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Strings.Unbounded, TicketProgramPackage;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Strings.Unbounded, TicketProgramPackage;

procedure TicketProgram is

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
        Put ("Purchase how many tickets to " & To_String (Dest.Name) & "?");
        New_Line;
        Put (">");
        Get (NumberTickets);

        if Dest.Supply - NumberTickets >= 0 and then NumberTickets > 0 then
            New_Line;
            Put ("Sufficient Supply");

            TotalCost := Dest.Cost * NumberTickets;

            New_Line;
            Put ("The total cost is > $");
            Money_IO.Put (TotalCost, Fore => 1, Aft => 2, Exp => 0);
            New_Line;
            Put ("Enter amount paid");
            New_Line;
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
            New_Line;
            Put ("Invalid Input");
        else
            New_Line;
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
            Put ("Train Departure Submenu:");
            New_Line;
            Put ("Type 'newburg' to process Train Departure to Newburg");
            New_Line;
            Put ("Type 'nyack' to process Train Departure to Nyack");
            New_Line;
            Put ("Type 'quit' to return to Main Menu");
            New_Line;
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
                    Put ("Invalid Input: Reenter");
                    New_Line;
                    New_Line;
            end case;
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

        case MenuChoice is
            when 1 =>
                New_Line;
                Sell_Tickets (Newburg_Route);
                New_Line;
            when 2 =>
                New_Line;
                Sell_Tickets (Nyack_Route);
                New_Line;
            when 3 =>
                New_Line;
                TrainDeparture;
                New_Line;
            when 4 =>
                New_Line;
                Check_Tickets (Newburg_Route.Supply, Nyack_Route.Supply);
                New_Line;
            when 5 =>
                New_Line;
                View_Total_Sales (TotalProfit);
                New_Line;
            when 6 =>
                null;
            when others =>
                New_Line;
                Put ("Invalid Input: Please enter 1-6");
                New_Line;
        end case;
    end loop;

end TicketProgram;
