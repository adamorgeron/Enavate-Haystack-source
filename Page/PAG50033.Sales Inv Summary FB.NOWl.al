page 50033 "Sales Inv Summary FB.NMOL"
{
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableTemporary = true;
    Caption = 'Summary by Billing Descripton';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(lines)
            {
                field("Billing Description.NOWL"; "Billing Description.NOWL") { ApplicationArea = All; Style = Strong; StyleExpr = Rec."Drop Shipment"; }
                field("Unit Price"; "Unit Price") { ApplicationArea = All; Style = Strong; StyleExpr = Rec."Drop Shipment"; BlankZero = true; }
                field(Quantity; Quantity) { ApplicationArea = All; Style = Strong; StyleExpr = Rec."Drop Shipment"; BlankZero = true; }
                field("Line Amount"; "Line Amount") { ApplicationArea = All; Style = Strong; StyleExpr = Rec."Drop Shipment"; }
            }
        }
    }

    procedure SetSalesHeader(var sh: Record "Sales Header")
    var
        sl: Record "Sales Line";
        line: Integer;
    begin
        clear(Rec);
        DeleteAll();
        sl.SetRange("document Type", sh."Document Type");
        sl.SetRange("Document No.", sh."No.");
        if sl.FindSet() then
            repeat
                SetRange("Billing Description.NOWL", sl."Billing Description.NOWL");
                SetRange("Unit Price", sl."Unit Price");
                if not FindFirst() then begin
                    init;
                    line += 1;
                    "Line No." := line;
                    "Billing Description.NOWL" := sl."Billing Description.NOWL";
                    "Unit Price" := sl."Unit Price";
                    insert();
                end;
                Quantity += sl.Quantity;
                "Line Amount" += sl."Line Amount";
                Modify();
            until sl.Next() = 0;
        Reset();
        init;
        CalcSums(Quantity, "Line Amount");
        line += 1;
        "Line No." := line;
        "Unit Price" := 0;
        "Billing Description.NOWL" := 'Totals';
        Rec."Drop Shipment" := true;
        insert();
    end;
}