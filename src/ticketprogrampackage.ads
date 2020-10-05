package TicketProgramPackage is

    procedure View_Total_Sales (TotalProfit : in Float);
    --Pre: Inputs Total Profit
    --Post: Outputs the total profit to the user

    procedure Check_Tickets
       (NewburgSupply : in Integer; NyackSupply : in Integer);
    --Pre: Input Integer values of the number of Newburg and Nyack tickets available
    --Post: Lists out the tickets available

    procedure Find_Change (TotalChange : in Float);
    --Pre: Input amount of change
--Post: Outputs the number of each increment of change that must be returned

end TicketProgramPackage;
