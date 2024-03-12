pageextension 50003 "Job Planning Lines.NOWL" extends "Job Planning Lines"
{
    /*
        NOWL00003, Columbus IT, US\BBR, 05 AUG 19
        Matter Maintenance

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
            Field("Matter Entry No.NOWL"; "Matter Entry No.NOWL")
            {
                ApplicationArea = All;
                Visible = False;
                Editable = false;
            }
            field("Matter Description.NOWL"; "Matter Description.NOWL")
            {
                ApplicationArea = All;
                Visible = false;
                Editable = false;
            }
            // NIGHT0002
            field("Billing Description.NOWL"; "Billing Description.NOWL")
            {
                ApplicationArea = all;
                
            }
            field("Customer No.NOWL"; "Customer No.NOWL")
            {
                Caption = 'Customer';
                ApplicationArea = All;
                Visible = false;
                Editable = false;

            }
            field("Customer Name.NOWL"; "Customer Name.NOWL")
            {
                Caption = 'Customer Name';
                ApplicationArea = All;
                Visible = false;
                Editable = false;

            }
            field("Time Sheet Resource No.NOWL"; "Time Sheet Resource No.NOWL")
            {
                Caption = 'Resource No.';
                ApplicationArea = All;
                Visible = false;
                Editable = false;

            }
            field("Time Sheet Resource Name.NOWL"; "Time Sheet Resource Name.NOWL")
            {
                Caption = 'Resource Name';
                ApplicationArea = All;
                Visible = false;
                Editable = false;

            }
            field("Your Reference.NOWL";"Your Reference.NOWL")
            {
                ToolTip = 'Your Reference';
                ApplicationArea = All;
                
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