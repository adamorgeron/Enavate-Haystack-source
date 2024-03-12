/*
NOWL00005, Columbus IT, US\BBR, 07 AUG 19
  Job Planning Lines

NIGHT0006, Columbus IT, GDC\RAVU, 27 OCT 20
-Added field "Your Reference 2"
*/

pageextension 50016 "Sales Credit Memo.NOWL" extends "Sales Credit Memo"
{
    layout
    {
        // Add changes to page layout here
        addafter("Salesperson Code")
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
                    IF "Matter Entry No.NOWL" = 0 then
                        exit;
                    Matter.SetRange("Entry No.", "Matter Entry No.NOWL");
                    Clear(MatterList);
                    MatterList.SetTableView(Matter);
                    MatterList.Editable := false;
                    MatterList.RunModal();
                    /*
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
                        Validate("Matter Contact No.NOWL", Matter."Bill-to Contact No.");
                    end;
                    */
                end;

                trigger OnValidate()
                begin
                    CurrPage.Update(false);
                end;

            }
            field("Your Reference 2.NOWL";"Your Reference 2.NOWL")
            {
                ApplicationArea = All;
                Caption = 'Your Reference 2';
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