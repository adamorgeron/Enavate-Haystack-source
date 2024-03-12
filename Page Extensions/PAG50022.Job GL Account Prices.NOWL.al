pageextension 50022 "Job G/L Account Prices.NOWL" extends "Job G/L Account Prices"
{
    /*
        NIGHT0002, Columbus IT, US\BBR, 10 JUN 20
        Billing Description

    */

    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Billing Description.NOWL"; "Billing Description.NOWL")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here        
    }

    var
        myInt: Integer;
}