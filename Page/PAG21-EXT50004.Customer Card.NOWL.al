/*
NOWL00003, Columbus IT, US\BBR, 05 AUG 19
  Matter Maintenance

*/

/*
NOWL00004, Columbus IT, US\BBR, 06 AUG 19
  Additional Job Information on TimeSheets
  Add "Minimum Hours" and "Hours Multiplier" to page layout

*/
pageextension 50004 "Customer Card.NOWL" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addlast(Invoicing)
        {
            field("Minimum Hours.NOWL"; "Minimum Hours.NOWL")
            {
                ApplicationArea = All;
            }
            field("Hours Multiplier.NOWL"; "Hours Multiplier.NOWL")
            {
                ApplicationArea = All;
            }
        }
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
                PromotedCategory = Category9;
                Image = Job;
            }
        }
    }

    var
        myInt: Integer;
}