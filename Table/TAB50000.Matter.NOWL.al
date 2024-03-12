/*
NOWL00003, Columbus IT, US\BBR, 05 AUG 19
  Matter Maintenance
  New Table

NIGHT0001, Columbus IT, US\BBR, 01 JUN 20
  Change Matter to Billing Reference

NIGHT0006, Columbus IT, GDC\RAVU, 27 OCT 20
-Added fields "Your Reference and Your Reference 2"
  

*/


table 50000 "Matter.NOWL"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Matters List.NOWL";
    DrillDownPageId = "Matters List.NOWL";
    Caption = 'Billing Reference';  // NIGHT0001

    fields
    {
        field(10; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(20; Number; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Number';

        }
        field(30; Description; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';

        }
        field(40; "Bill-to Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            Caption = 'Bill-to Customer No.';
            Trigger OnValidate()
            var
                "Customer.NOWL": Record Customer;
            begin
                CalcFields(Name);
                IF "Bill-to Customer No." <> xRec."Bill-to Customer No." then begin
                    // NIGHT0001
                    if not "Customer.NOWL".get("Bill-to Customer No.") then
                        "Customer.NOWL".init;
                    "Salesperson Code.NOWL" := "Customer.NOWL"."Salesperson Code";
                    "Bill-to Contact No." := '';
                    CalcFields("Bill-to Contact Name");
                end;
            End;

        }
        field(50; "Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Bill-to Customer No.")));
            Editable = false;

        }
        field(60; "Bill-to Contact No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill-to Contact No.';
            trigger OnValidate()
            begin
                ShowContact(false);
                CalcFields("Bill-to Contact Name");
            end;

            trigger OnLookup()
            begin
                ShowContact(true);
            end;
        }
        field(70; "Bill-to Contact Name"; Text[100])
        {
            FieldClass = FlowField;
            Caption = 'Bill-to Contact Name';
            CalcFormula = lookup(Contact.Name where("No." = field("Bill-to Contact No.")));
            Editable = false;

        }
        field(80; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Closed';
        }
        // NIGHT0001
        field(90; "Salesperson Code.NOWL"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";

        }
        field(100; "Your Reference.NOWL"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Your Reference';

        }
        field(110; "Your Reference 2.NOWL"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Your Reference 2';

        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key1; "Bill-to Customer No.", "Bill-to Contact No.", Closed)
        {

        }
    }

    var
        myInt: Integer;
        Text001: Label '%1 must be populated';
        Text002: Label 'Matter %1 may not be deleted. It is in use';

    trigger OnInsert()
    begin
        IF StrLen(Description) = 0 then
            error(StrSubstNo(Text001, FieldCaption(Description)));
        IF StrLen("Bill-to Customer No.") = 0 then
            error(StrSubstNo(Text001, FieldCaption("Bill-to Customer No.")));

    end;

    trigger OnModify()
    begin
        IF StrLen(Description) = 0 then
            error(StrSubstNo(Text001, FieldCaption(Description)));
        IF StrLen("Bill-to Customer No.") = 0 then
            error(StrSubstNo(Text001, FieldCaption("Bill-to Customer No.")));

    end;

    trigger OnDelete()
    var
        Job: Record Job;
    begin
        Job.SetRange("Matter Entry No.NOWL", "Entry No.");
        if not Job.IsEmpty then
            Error(StrSubstNo(Text002, Description));
    end;

    trigger OnRename()
    begin

    end;

    procedure ShowContact(ForLookup: Boolean)
    var
        ContBusRel: Record "Contact Business Relation";
        Cont: Record Contact;
        OfficeContact: Record Contact;
        OfficeMgt: Codeunit "Office Management";
        ConfirmManagement: Codeunit "Confirm Management";
        UpdateContFromCust: Codeunit "CustCont-Update";
        Customer: Record Customer;
        ContactList: Page "Contact List";
        Cont2: Record Contact;
    begin
        IF OfficeMgt.GetContact(OfficeContact, "Bill-to Customer No.") AND (OfficeContact.COUNT = 1) THEN
            PAGE.RUN(PAGE::"Contact Card", OfficeContact)
        ELSE BEGIN
            IF "Bill-to Customer No." = '' THEN
                EXIT;

            ContBusRel.SETCURRENTKEY("Link to Table", "No.");
            ContBusRel.SETRANGE("Link to Table", ContBusRel."Link to Table"::Customer);
            ContBusRel.SETRANGE("No.", "Bill-to Customer No.");
            IF NOT ContBusRel.FINDFIRST THEN BEGIN
                IF NOT ConfirmManagement.GetResponse(STRSUBSTNO(Text002, TABLECAPTION, "Bill-to Customer No."), TRUE) THEN
                    EXIT;
                IF NOT Customer.GET("Bill-to Customer No.") then
                    EXIT;
                UpdateContFromCust.InsertNewContact(Customer, FALSE);
                ContBusRel.FINDFIRST;
            END;
            COMMIT;

            Cont.FILTERGROUP(2);
            Cont.SETRANGE("Company No.", ContBusRel."Contact No.");
            IF Cont.ISEMPTY THEN BEGIN
                Cont.SETRANGE("Company No.");
                Cont.SETRANGE("No.", ContBusRel."Contact No.");
            END;
            if ForLookup Then begin
                Clear(ContactList);
                ContactList.SetTableView(Cont);
                ContactList.LookupMode(true);
                if action::LookupOK = ContactList.RunModal() then begin
                    ContactList.GetRecord(Cont2);
                    Validate("Bill-to Contact No.", Cont2."No.");
                end;
            end else begin
                Cont.SetRange("No.", "Bill-to Contact No.");
                Cont.FindFirst();
            end;

        END;

    end;
}