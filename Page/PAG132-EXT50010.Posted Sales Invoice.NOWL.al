/*
NOWL00005, Columbus IT, US\BBR, 07 AUG 19
  Job Planning Lines

NIGHT0006, Columbus IT, GDC\RAVU, 27 OCT 20
-Added field "Your Reference 2"
-Added action "Update Posted Invoice"

NIGHT0011, Columbus IT, US\BBR, 04 MAR 21
  Correct field numbering on posted invoice tables to support TRANSFERFIELD behavior of base app


*/

pageextension 50010 "Posted Sales Invoice.NOWL" extends "Posted Sales Invoice"
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
            field("Your Reference 2.NOWL"; "Your Reference 3.NOWL")  // , Columbus IT, US\BBR, 04 MAR 21
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
            action(UpdatePostedInvoice)
            {
                Caption = 'Update Posted Invoice';
                ApplicationArea = All;
                ToolTip = 'Update Your Reference 2';
                Image = Process;
                trigger OnAction()
                var
                    SalesInvoice: Record "Sales Invoice Header";
                    UpdateInvoice: Page "Update Posted Invoice.NOWL";
                begin
                    SalesInvoice.COPY(Rec);
                    CurrPage.SETSELECTIONFILTER(SalesInvoice);
                    SalesInvoice.MARKEDONLY(TRUE);
                    UpdateInvoice.SETTABLEVIEW(SalesInvoice);
                    if UpdateInvoice.RunModal() = Action::OK then
                        CurrPage.Update(false);

                end;

            }

        }

    }

    var
        myInt: Integer;
}