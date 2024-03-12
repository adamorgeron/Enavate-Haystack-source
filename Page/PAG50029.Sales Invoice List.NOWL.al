pageextension 50029 "Sales Invoice List.NOWL" extends "Sales Invoice List"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Matter Description 2.NOWL"; "Matter Description 2.NOWL")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Description from Job Planning Lines';
            }
        }
    }
}