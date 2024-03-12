pageextension 50026 "Resource Card.NOWL" extends "Resource Card"
{
   /*  NIGHT0006, Columbus IT, GDC\RAVU, 27 OCT 20
    -Added field "Billing Description" */
    layout
    {

        addafter("VAT Prod. Posting Group")
        {
            field("Billing Description.NOWL";"Billing Description.NOWL")
            {
                ApplicationArea = All;
                ToolTip = 'Billing Description';
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