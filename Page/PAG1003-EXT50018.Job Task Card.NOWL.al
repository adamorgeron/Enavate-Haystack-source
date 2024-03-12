pageextension 50018 "Job Task Card.NOWL" extends "Job Task Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Job Task Type")
        {
            field("Billing Ref. Description.NOWL"; "Billing Ref. Description.NOWL")
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
                    MatterList.SetTableView(Matter);
                    MatterList.LookupMode(true);
                    If MatterList.RunModal() = Action::LookupOK then begin
                        MatterList.GetRecord(Matter);
                        Validate("Billing Ref. Entry No.NOWL", Matter."Entry No.");
                        Modify();
                        CurrPage.Update(false);
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