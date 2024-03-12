/*
NOWL00005, Columbus IT, US\BBR, 07 AUG 19
  Job Planning Lines
NIGHT0006, Columbus IT, GDC\RAVU, 27 OCT 20
-Added field "Your Reference 2"

*/

pageextension 50009 "Sales Invoice.NOWL" extends "Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("Salesperson Code")
        {
            field("Matter Description.NOWL"; "Matter Description.NOWL")
            {
                ApplicationArea = All;
                Editable = false;

                trigger OnDrillDown()
                var
                    Matter: Record "Matter.NOWL";
                    MatterList: Page "Matters List.NOWL";
                begin
                    IF "Matter Entry No.NOWL" = 0 then
                        exit;
                    Matter.SetRange("Entry No.", "Matter Entry No.NOWL");
                    Clear(MatterList);
                    MatterList.SetTableView(Matter);
                    MatterList.Editable := false;
                    MatterList.RunModal();
                    /*
                    Clear(MatterList);
                    Matter.SETRANGE(Closed, false);
                    if "Bill-to Customer No." > '' THEN
                        Matter.SetRange("Bill-to Customer No.", "Bill-to Customer No.")
                    else
                        Matter.SetRange("Bill-to Customer No.", "Sell-to Customer No.");
                    MatterList.SetTableView(Matter);
                    //MatterList.Editable := false;
                    MatterList.LookupMode(true);
                    If MatterList.RunModal() = Action::LookupOK then begin
                        MatterList.GetRecord(Matter);
                        Validate("Matter Entry No.NOWL", Matter."Entry No.");
                        Validate("Matter Contact No.NOWL", Matter."Bill-to Contact No.");
                        Modify();
                        CurrPage.Update(false);
                    end;
                    */
                end;

            }
            field("Matter Description 2.NOWL"; "Matter Description 2.NOWL")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Description from Job Planning Lines';


            }
            field("Your Reference 2.NOWL"; "Your Reference 2.NOWL")
            {
                ApplicationArea = All;
                ToolTip = 'Your Reference 2';
            }


        }
        addafter(ApprovalFactBox)
        {
            part("SalesInvSummaryFB.SSI"; "Sales Inv Summary FB.NMOL")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetRecord()
    var
        SalesLine: Record "Sales Line";
        Matter: Record "Matter.NOWL";
    begin
        CurrPage."SalesInvSummaryFB.SSI".Page.SetSalesHeader(Rec);
        /* Bad Code Removed - BBR
         SalesLine.SetRange("Document Type","Document Type"::Invoice);
         SalesLine.SetRange("Document No.","No.");
         if SalesLine.FindFirst() then begin
             SalesLine.CalcFields(SalesLine."Matter Description.NOWL");
          if  Rec."Matter Description 2.NOWL" <> SalesLine."Matter Description.NOWL" then;
            Rec."Matter Description 2.NOWL" := SalesLine."Matter Description.NOWL";
            

         IF Matter.get(Rec."Matter Entry No.NOWL" = 0) then
            Rec.VALIDATE("Salesperson Code" ,Matter."Salesperson Code.NOWL");// NIGHT0006
           Rec.Modify();
        end;
        */
    end;

    var
        myInt: Integer;
}