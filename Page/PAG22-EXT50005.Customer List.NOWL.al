/*
NOWL00003, Columbus IT, US\BBR, 05 AUG 19
  Matter Maintenance

*/

pageextension 50005 "Customer List.NOWL" extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addlast("&Customer")
        {
            Action(Matter)
            {
                Caption = 'Billing Reference';
                ApplicationArea = All;
                RunObject = Page "Matters List.NOWL";
                RunPageView = sorting("Bill-to Customer No.", "Bill-to Contact No.", Closed);
                RunPageLink = "Bill-to Customer No." = FIELD("No.");
                Promoted = true;
                PromotedCategory = Category7;
                Image = Job;
            }
        }

    }

    var
        myInt: Integer;
}