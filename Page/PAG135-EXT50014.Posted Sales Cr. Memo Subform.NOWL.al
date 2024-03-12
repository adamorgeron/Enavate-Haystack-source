pageextension 50014 "Posted Sales Cr. Memo Sub.NOWL" extends "Posted Sales Cr. Memo Subform"
{
    /*
        NOWL00005, Columbus IT, US\BBR, 07 AUG 19
        Job Planning Lines

        NIGHT0002, Columbus IT, US\BBR, 10 JUN 20
        Billing Description

        NIGHT0006, Columbus IT, GDC\RAVU, 27 OCT 20
        -Added field "Your Reference,Your Reference 2"
    */

    layout
    {
        // Add changes to page layout here
        addafter("Unit of Measure Code")
        {
            field("Matter Description.NOWL"; "Matter Description.NOWL")
            {
                ApplicationArea = All;
                Editable = false;

            }
            // NIGHT0002
            field("Billing Description.NOWL"; "Billing Description.NOWL")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Your Reference.NOWL";"Your Reference.NOWL")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Your Reference';
            }
            field("Your Reference 2.NOWL";"Your Reference 2.NOWL")
            {
                ApplicationArea = All;
                Editable = false;
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