pageextension 50031 "Sales Credit Memos.NOWL" extends "Sales Credit Memos"
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