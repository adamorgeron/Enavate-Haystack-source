pageextension 50012 "Posted Sales Inv. Subform.NOWL" extends "Posted Sales Invoice Subform"
{
    /*
    NOWL00005, Columbus IT, US\BBR, 07 AUG 19
      Job Planning Lines

    NIGHT0002, Columbus IT, US\BBR, 10 JUN 20
      Billing Description
    NIGHT0006, Columbus IT, GDC\RAVU, 27 OCT 20
    -Added field "Your Reference,Your Reference 2"

    NIGHT0011, Columbus IT, US\BBR, 04 MAR 21
    Correct field numbering on posted invoice tables to support TRANSFERFIELD behavior of base app


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
            field("Your Reference.NOWL"; "Your Reference.NOWL")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Your Reference';
            }
            field("Your Reference 2.NOWL"; "Your Reference 3.NOWL")  // NIGHT0011
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