/*
NOWL00001, Columbus IT, US\BBR, 07 JUN 19
  Time Sheets with other Resources

NOWL00004, Columbus IT, US\BBR, 06 AUG 19
  Additional Job Information on TimeSheets
  Add "Line Comment"

*/
pageextension 50000 "Time Sheet.NOWL" extends "Time Sheet"
{

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
                if Description > '' then
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
        modify(Field1)
        {
            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;
        }
        modify(Field2)
        {
            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;
        }
        modify(Field3)
        {
            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;
        }
        modify(Field4)
        {
            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;
        }
        modify(Field5)
        {
            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;
        }
        modify(Field6)
        {
            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;
        }
        modify(Field7)
        {
            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;
        }

        addafter("Job Task No.")
        {
            // NOWL00005
            field("Matter Description.NOWL"; "Matter Description.NOWL")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Billing Reference';
            }
            field("Customer Name.NOWL"; "Customer Name.NOWL")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Client';
            }
        }

        addafter(Description)
        {
            field("Line Comment.NOWL"; "Line Comment.NOWL")
            {
                ApplicationArea = All;
                Caption = 'Comment';
            }
        }
        addlast(Content)
        {
            part(ResourceTime; "Time Sheet Subpage.NOWL")
            {
                SubPageLink = Type = Field(Type), "Job No." = Field("Job No."), "Job Task No." = Field("Job Task No."), "Time Sheet Starting Date" = Field("Time Sheet Starting Date");
                Caption = 'Resource Time Entry';
                ApplicationArea = All;
                Visible = ShowResourceTime;

            }
        }


    }


    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    begin
        ShowResourceTime := "IsPerson.NOWL"();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if ShowResourceTime then
            CurrPage.ResourceTime.Page.SetPersonTimeSheetHeader("Time Sheet No.", "Line No.");

    end;

    trigger OnAfterGetCurrRecord()
    begin
        if ShowResourceTime then
            CurrPage.ResourceTime.Page.SetPersonTimeSheetHeader("Time Sheet No.", "Line No.");
    end;

    var
        ShowResourceTime: Boolean;

}