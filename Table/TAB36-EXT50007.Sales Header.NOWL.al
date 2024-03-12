/*
NOWL00005, Columbus IT, US\BBR, 07 AUG 19
  Job Planning Lines


NIGHT0001, Columbus IT, US\BBR, 01 JUN 20
  Change Matter to Billing Reference

NIGHT0006, Columbus IT, GDC\RAVU, 27 OCT 20
-Added fields "Your Reference and Your Reference 2"

*/
tableextension 50007 "Sales Header.NOWL" extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Matter Entry No.NOWL"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Billing Reference Entry No.';    // NIGHT0001  //'Matter Entry No.';
            Editable = false;
        }
        field(50010; "Matter Description.NOWL"; Text[50])
        {
            Caption = 'Billing Reference Description';  // NIGHT0001  //'Matter Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Matter.NOWL".Description where("Entry No." = field("Matter Entry No.NOWL")));
            Editable = false;

        }
        field(50011; "Matter Description 2.NOWL"; Text[50])
        {
            Caption = 'Line Billing Reference Description';  // NIGHT0001  //'Matter Description';
            DataClassification = CustomerContent;
        }
        field(50020; "Matter Contact No.NOWL"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Matter Contact No.';
            Editable = false;
            TableRelation = "Contact Business Relation" where("Link to Table" = CONST(Customer), "No." = FIELD("Bill-to Customer No."));
        }
        field(50030; "Matter Contact Name.NOWL"; Text[100])
        {
            FieldClass = FlowField;
            Caption = 'Matter Contact Name';
            CalcFormula = lookup(Contact.Name where("No." = field("Matter Contact No.NOWL")));
            Editable = false;

        }

        field(50050; "Your Reference 2.NOWL"; Text[35])
        {
            Caption = 'Your Reference2';
            DataClassification = CustomerContent;
        }

    }
    var
        myInt: Integer;
}