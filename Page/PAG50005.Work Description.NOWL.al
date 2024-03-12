/*

*/
page 50005 "Work Description.NOWL"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Work Description.NOWL";
    Caption = 'Work Description';


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Description; Description)
                {
                    ApplicationArea = All;

                }
                field(Internal; Internal)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}