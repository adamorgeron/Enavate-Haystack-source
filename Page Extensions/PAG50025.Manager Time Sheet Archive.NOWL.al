pageextension 50025 "Manager Time Sheet Arch.NOWL" extends "Manager Time Sheet Archive"
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
        addafter("Job Task No.")
        {
            field("Customer No.NOWL"; "Customer No.NOWL")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Customer';
                Visible = false;
            }
        }

        addafter(Description)
        {
            field("Line Comment.NOWL"; "Line Comment.NOWL")
            {
                ApplicationArea = All;
                Caption = 'Comment';
                Visible = false;
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