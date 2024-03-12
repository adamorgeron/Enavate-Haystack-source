pageextension 50007 "Job Journal.NOWL" extends "Job Journal"
{
    /*

        NOWL00004, Columbus IT, US\BBR, 06 AUG 19
        Additional Job Information on TimeSheets

        NIGHT0001, Columbus IT, US\BBR, 01 JUN 20
        Change Matter to Billing Reference

        NIGHT0002, Columbus IT, US\BBR, 10 JUN 20
        Billing Description

    */
    layout
    {
        // Add changes to page layout here
        addafter("Job Task No.")
        {
            field("Customer No.NOWL"; "Customer No.NOWL")
            {
                ApplicationArea = All;
                Caption = 'Customer';
                Visible = false;
            }
            field("Matter Description.NOWL"; "Matter Description.NOWL")
            {
                ApplicationArea = All;
                Caption = 'Billing Ref.';  // NIGHT0001  //'Matter';
                Visible = true;
                trigger OnDrillDown()
                var
                    Matter: Record "Matter.NOWL";
                    MatterList: Page "Matters List.NOWL";
                begin
                    Clear(MatterList);
                    Matter.SETRANGE(Closed, false);
                    Matter.SetRange("Bill-to Customer No.", "Customer No.NOWL");
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
            field("Time Sheet Resource Name.NOWL"; "Time Sheet Resource Name.NOWL")
            {
                ApplicationArea = All;
                Caption = 'Resource Name';
                Visible = false;
            }
            field("Your Reference.NOWL";"Your Reference.NOWL")
            {
                ApplicationArea = All;
                ToolTip = 'Your Reference';
            }
            field("Your Reference 2.NOWL";"Your Reference 2.NOWL")
            {
                ApplicationArea = All;
                ToolTip = 'Your Reference 2';
            }
        }

        addafter(Description)
        {
            field("Line Comment.NOWL"; "Line Comment.NOWL")
            {
                ApplicationArea = All;
                Caption = 'Comment';
            }
            // NIGHT0002
            field("Billing Description.NOWL"; "Billing Description.NOWL")
            {
                ApplicationArea = all;
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