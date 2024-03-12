page 50028 "Update Posted Credit Memo.NOWL"
{
/*     NIGHT0006, Columbus IT, GDC\RAVU, 27 OCT 20
    -Added page "Update posted credit memo */
    Caption = 'Update Posted Credit Memo';
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Cr.Memo Header";
    AccessByPermission = tabledata "Sales Cr.Memo Header" = RIM;
    Permissions = tableData "Sales Cr.Memo Header" = rim;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Your Reference 2.NOWL"; "Your Reference 2.NOWL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Your Reference 2';

                }
            }
        }
    }


}