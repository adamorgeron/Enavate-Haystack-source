/*
NOWL00005, Columbus IT, US\BBR, 07 AUG 19
  Job Planning Lines

NIGHT0006, Columbus IT, GDC\RAVU, 27 OCT 20
-Added field "Your Reference 2"
-Added Action "Update Posted Credit Memo"

*/

pageextension 50013 "Posted Sales Credit Memo.NOWL" extends "Posted Sales Credit Memo"
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

            }
            
            field("Your Reference 2.NOWL";"Your Reference 2.NOWL")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Your Reference 2';
            }

        }

    }

    actions
    {
        addafter(Statistics)
        {
            action(UpdatePostedCreditMemo)
            {
                Caption = 'Update Posted Credit Memo';
                ApplicationArea = All;
                ToolTip = 'Update Your Reference 2';
                Image = Process;
                trigger OnAction()
                var
                    SalesCreditMemo : Record "Sales Cr.Memo Header";
                    UpdateCreditMemo : Page "Update Posted Credit Memo.NOWL";
                begin
                    SalesCreditMemo.COPY(Rec);
                    CurrPage.SETSELECTIONFILTER(SalesCreditMemo);
                    SalesCreditMemo.MARKEDONLY(TRUE);
                    UpdateCreditMemo.SETTABLEVIEW(SalesCreditMemo);
                   if UpdateCreditMemo.RunModal() = Action::OK then
                    CurrPage.Update(false);

                end;

            }

        }
    }

    var
        myInt: Integer;
}