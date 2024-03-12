pageextension 50020 "Job Task Lines Subform.NOWL" extends "Job Task Lines Subform"
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
                    "Job.NOWL": Record Job;
                begin
                    TestField("Job Task No.");
                    "Job.NOWL".get("Job No.");
                    "Job.NOWL".testfield("Bill-to Customer No.");
                    Clear(MatterList);
                    Matter.SETRANGE(Closed, false);
                    Matter.SETRANGE("Bill-to Customer No.", "Job.NOWL"."Bill-to Customer No.");
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