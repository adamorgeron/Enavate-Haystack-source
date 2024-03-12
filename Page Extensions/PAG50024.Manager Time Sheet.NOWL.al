pageextension 50024 "Manager Time Sheet.NOWL" extends "Manager Time Sheet"
{
    /*
    NIGHT0005, Columbus IT, US\BBR, 11 SEP 20
      Move changes to Manager Time Sheets

    */
    layout
    {
        // Add changes to page layout here
        modify("Job No.")
        {
            Visible = true;
        }
        modify("Job Task No.")
        {
            Visible = true;
        }
        modify(Description)
        {
            Editable = false;
            trigger OnAssistEdit()
            var
                WorkDescription: Record "Work Description.NOWL";
                WorkDescriptions: Page "Work Description.NOWL";
            begin
                If Description > '' then
                    Exit;
                Clear(WorkDescriptions);
                WorkDescriptions.SetTableView(WorkDescription);
                WorkDescriptions.LookupMode(true);
                if WorkDescriptions.RunModal = Action::LookupOK THEN begin
                    WorkDescriptions.GetRecord(WorkDescription);
                    Description := WorkDescription.Description;
                    CurrPage.Update();
                end;
            end;

        }
        addafter("Job Task No.")
        {
            field("Customer No.NOWL"; "Customer No.NOWL")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Customer';
                Visible = false;
            }
            field("Matter Description.NOWL"; "Matter Description.NOWL")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Billing Reference Description';  // NIGHT0001  //'Matter';
                Visible = true;
            }
        }

        addafter(Description)
        {
            field("Line Comment.NOWL"; "Line Comment.NOWL")
            {
                ApplicationArea = All;
                Caption = 'Comment';
                Visible = true;
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