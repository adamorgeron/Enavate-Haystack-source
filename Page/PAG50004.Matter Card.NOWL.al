
/*
NOWL00003, Columbus IT, US\BBR, 05 AUG 19
  Matter Maintenance

NIGHT0001, Columbus IT, US\BBR, 01 JUN 20
  Change Matter to Billing Reference
  
NIGHT0006, Columbus IT, GDC\RAVU, 27 OCT 20
-Added field "Your Reference and Your Reference 2"

*/
page 50004 "Matter Card.NOWL"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Matter.NOWL";
    Caption = 'Billing Reference Card';   // NIGHT0001 //Matter Card';
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            group(General)
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
                // NIGHT0001
                field("Salesperson Code.NOWL"; "Salesperson Code.NOWL")
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
                field("Your Reference.NOWL";"Your Reference.NOWL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Your Reference';
                }
                field("Your Reference 2.NOWL";"Your Reference 2.NOWL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Your Reference 2';

                }
            }
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