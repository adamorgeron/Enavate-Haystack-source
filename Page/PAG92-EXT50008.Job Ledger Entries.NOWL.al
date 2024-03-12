pageextension 50008 "Job Ledger Entries.NOWL" extends "Job Ledger Entries"
{
    /*

        NOWL00004, Columbus IT, US\BBR, 06 AUG 19
        Additional Job Information on TimeSheets

        NIGHT0002, Columbus IT, US\BBR, 10 JUN 20
        Billing Description

        NIGHT0006, Columbus IT, GDC\RAVU, 27 OCT 20
        -Added field "Your Reference,Your Reference 2"
    */

    layout
    {
        // Add changes to page layout here

        addafter(Description)
        {
            field("Line Comment.NOWL"; "Line Comment.NOWL")
            {
                ApplicationArea = All;
                Caption = 'Comment';
            }
            // NIGHT0002
            field("Billing Description.NOWL"; "Billing Description.NOWL")
            {
                ApplicationArea = all;
            }
            field("Your Reference.NOWL";"Your Reference.NOWL")
            {
                ApplicationArea = All;
                ToolTip = 'Your Reference';
            }
            field("Your Reference 2.NOWL";"Your Reference 2.NOWL")
            {
                ApplicationArea = All;
                ToolTip = 'Your Reference 2';
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