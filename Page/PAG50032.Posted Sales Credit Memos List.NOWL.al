pageextension 50032 "Posted Sales Credit Memos.NOWL" extends "Posted Sales Credit Memos"
{
    layout
    {
        addbefore("Currency Code")
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