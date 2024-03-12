page 50027 "Update Posted Invoice.NOWL"
{

    /*
        NIGHT0011, Columbus IT, US\BBR, 04 MAR 21
        Correct field numbering on posted invoice tables to support TRANSFERFIELD behavior of base app


    */

    Caption = 'Update Posted Invoice';
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Invoice Header";
    AccessByPermission = tabledata "Sales Invoice Header" = RIM;
    Permissions = tableData "Sales Invoice Header" = rim;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Your Reference 2.NOWL"; "Your Reference 3.NOWL")  // NIGHT0011
                {
                    ApplicationArea = All;
                    ToolTip = 'Your Reference 2';

                }
            }
        }
    }


}