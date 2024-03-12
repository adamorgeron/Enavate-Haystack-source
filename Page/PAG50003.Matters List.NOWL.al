
/*
NOWL00003, Columbus IT, US\BBR, 05 AUG 19
  Matter Maintenance

NIGHT0001, Columbus IT, US\BBR, 01 JUN 20
  Change Matter to Billing Reference

*/
page 50003 "Matters List.NOWL"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Matter.NOWL";
    Editable = false;
    Caption = 'Billing Reference List';  // NIGHT0001  //'Matters List';
    CardPageId = "Matter Card.NOWL";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Number; Number)
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact No."; "Bill-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact Name"; "Bill-to Contact Name")
                {
                    ApplicationArea = All;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = All;
                }

            }
        }
        area(Factboxes)
        {

        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        Matter: Record "Matter.NOWL";
    begin
        Matter.Copy(Rec);
        IF Matter.GetFilter("Bill-to Customer No.") > '' THEN
            VALIDATE("Bill-to Customer No.", Matter.GetFilter("Bill-to Customer No."));
    end;
}