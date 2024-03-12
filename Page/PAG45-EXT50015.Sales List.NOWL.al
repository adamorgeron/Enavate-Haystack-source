/*
NOWL00005, Columbus IT, US\BBR, 07 AUG 19
  Job Planning Lines


*/

pageextension 50015 "Sales List.NOWL" extends "Sales List"
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

        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}