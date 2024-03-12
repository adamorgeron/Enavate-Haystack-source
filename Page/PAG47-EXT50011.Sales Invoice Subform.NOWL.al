pageextension 50011 "Sales Invoice Subform.NOWL" extends "Sales Invoice Subform"
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
                trigger OnDrillDown()
                var
                    Matter: Record "Matter.NOWL";
                    MatterList: Page "Matters List.NOWL";
                begin
                    Clear(MatterList);
                    Matter.SETRANGE(Closed, false);
                    if "Bill-to Customer No." > '' THEN
                        Matter.SetRange("Bill-to Customer No.", "Bill-to Customer No.")
                    else
                        Matter.SetRange("Bill-to Customer No.", "Sell-to Customer No.");
                    MatterList.SetTableView(Matter);
                    MatterList.LookupMode(true);
                    If MatterList.RunModal() = Action::LookupOK then begin
                        MatterList.GetRecord(Matter);
                        Validate("Matter Entry No.NOWL", Matter."Entry No.");
                        CalcFields("Matter Description.NOWL");
                        //Modify();  // NIGHT0001
                        //CurrPage.Update(false);
                    end;
                end;


            }
            // NIGHT0002
            field("Billing Description.NOWL"; "Billing Description.NOWL")
            {
                ApplicationArea = all;
            }
            field("Your Reference.NOWL"; "Your Reference.NOWL")
            {
                ApplicationArea = All;
                ToolTip = 'Your Reference';
            }
            field("Your Reference 2.NOWL"; "Your Reference 2.NOWL")
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