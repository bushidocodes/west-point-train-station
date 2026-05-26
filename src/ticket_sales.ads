with Ada.Text_IO;
package Ticket_Sales is

    type Money is delta 0.01 digits 10;
    package Money_IO is new Ada.Text_IO.Decimal_IO (Money);

    procedure View_Total_Sales (TotalProfit : in Money)
       with Pre => TotalProfit >= 0.00;

    procedure Check_Tickets
       (NewburgSupply : in Natural; NyackSupply : in Natural);

    procedure Find_Change (TotalChange : in Money)
       with Pre => TotalChange >= 0.00;

end Ticket_Sales;
