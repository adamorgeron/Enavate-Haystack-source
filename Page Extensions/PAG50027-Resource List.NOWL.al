pageextension 50027 "Resource List.NOWL" extends "Resource List"
{
    layout
    {
        addafter(Name)
        {
            field("Billing Description.NOWL";"Billing Description.NOWL")
            {
                ApplicationArea = All;
                ToolTip = 'Billing Description';
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