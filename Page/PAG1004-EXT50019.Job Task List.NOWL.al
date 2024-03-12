pageextension 50019 "Job Task List.NOWL" extends "Job Task List"
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