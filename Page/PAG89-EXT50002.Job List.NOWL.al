/*
NOWL00003, Columbus IT, US\BBR, 05 AUG 19
  Matter Maintenance

*/

pageextension 50002 "Job List.NOWL" extends "Job List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Search Description")
        {
            field("Matter Entry No.NOWL"; "Matter Entry No.NOWL")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;

            }

        }
        addafter("Search Description")
        {
            field("Matter Description.NOWL"; "Matter Description.NOWL")
            {
                ApplicationArea = All;
                Editable = false;
                trigger OnAssistEdit()
                var
                    Matter: Record "Matter.NOWL";
                    MatterList: Page "Matters List.NOWL";
                begin
                    Clear(MatterList);
                    Matter.SETRANGE(Closed, false);
                    Matter.SetRange("Bill-to Customer No.", "Bill-to Customer No.");
                    MatterList.SetTableView(Matter);
                    MatterList.LookupMode(true);
                    If MatterList.RunModal() = Action::LookupOK then begin
                        MatterList.GetRecord(Matter);
                        Validate("Matter Entry No.NOWL", Matter."Entry No.");
                    end;
                end;
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