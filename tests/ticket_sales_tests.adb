with Ada.Text_IO; use Ada.Text_IO;
with Ticket_Sales; use Ticket_Sales;

procedure Ticket_Sales_Tests is

    Passed : Natural := 0;
    Failed : Natural := 0;

    procedure Check (Got : Natural; Expected : Natural; Label : String) is
    begin
        if Got = Expected then
            Passed := Passed + 1;
        else
            Put_Line ("FAIL: " & Label
                      & " — expected" & Expected'Image
                      & ", got" & Got'Image);
            Failed := Failed + 1;
        end if;
    end Check;

    procedure Check_Change
       (Amount   : Money;
        Dollars  : Natural;
        Quarters : Natural;
        Dimes    : Natural;
        Nickels  : Natural;
        Pennies  : Natural;
        Label    : String)
    is
        C : constant Change_Breakdown := Calculate_Change (Amount);
    begin
        Check (C.Dollars,  Dollars,  Label & " dollars");
        Check (C.Quarters, Quarters, Label & " quarters");
        Check (C.Dimes,    Dimes,    Label & " dimes");
        Check (C.Nickels,  Nickels,  Label & " nickels");
        Check (C.Pennies,  Pennies,  Label & " pennies");
    end Check_Change;

    procedure Check_Exact
       (Amount   : Money;
        Expected : Boolean;
        Label    : String)
    is
    begin
        if Is_Exact_Change (Amount) = Expected then
            Passed := Passed + 1;
        else
            Put_Line ("FAIL: " & Label
                      & " — expected " & Expected'Image
                      & ", got " & Is_Exact_Change (Amount)'Image);
            Failed := Failed + 1;
        end if;
    end Check_Exact;

begin
    Check_Change (0.00, 0, 0, 0, 0, 0, "$0.00 exact change");
    Check_Change (1.00, 1, 0, 0, 0, 0, "$1.00 single dollar");
    Check_Change (0.25, 0, 1, 0, 0, 0, "$0.25 single quarter");
    Check_Change (0.10, 0, 0, 1, 0, 0, "$0.10 single dime");
    Check_Change (0.05, 0, 0, 0, 1, 0, "$0.05 single nickel");
    Check_Change (0.01, 0, 0, 0, 0, 1, "$0.01 single penny");
    Check_Change (1.86, 1, 3, 1, 0, 1, "$1.86 mixed denominations");
    Check_Change (0.06, 0, 0, 0, 1, 1, "$0.06 nickel and penny");
    Check_Change (0.99, 0, 3, 2, 0, 4, "$0.99 near-dollar");
    Check_Change (3.50, 3, 2, 0, 0, 0, "$3.50 Newburg fare change from $7");
    Check_Change (5.25, 5, 1, 0, 0, 0, "$5.25 Nyack fare change from $10.50");
    Check_Change (1.41, 1, 1, 1, 1, 1, "$1.41 all five denominations");
    Check_Change (0.30, 0, 1, 0, 1, 0, "$0.30 quarter and nickel not three dimes");
    Check_Change (3.76, 3, 3, 0, 0, 1, "$3.76 multiple dollars with trailing coins");
    Check_Change (0.75, 0, 3, 0, 0, 0, "$0.75 max quarters");

    Check_Exact (0.00, True,  "0.00 is exact change");
    Check_Exact (0.01, False, "0.01 is not exact change");
    Check_Exact (3.50, False, "3.50 is not exact change");

    Put_Line (Passed'Image & " passed," & Failed'Image & " failed.");
    if Failed > 0 then
        raise Program_Error with "test suite failed";
    end if;

end Ticket_Sales_Tests;
