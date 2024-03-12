pageextension 50030 "Posted Sales Invoices.NOWL" extends "Posted Sales Invoices"
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