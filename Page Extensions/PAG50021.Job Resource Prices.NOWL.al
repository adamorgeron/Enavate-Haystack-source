pageextension 50021 "Job Resource Prices.NOWL" extends "Job Resource Prices"
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