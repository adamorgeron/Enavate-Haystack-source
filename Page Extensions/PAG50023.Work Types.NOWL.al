pageextension 50023 "Work Types.NOWL" extends "Work Types"
{
    /*
    NIGHT0003, Columbus IT, US\BBR, 16 JUL 20
    Gen Prod PG by Work Type

    */
    layout
    {
        // Add changes to page layout here
        addafter("Unit of Measure Code")
        {
            field("Gen. Prod. Posting Group.NOWL"; "Gen. Prod. Posting Group.NOWL")
            {
                ApplicationArea = All;
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