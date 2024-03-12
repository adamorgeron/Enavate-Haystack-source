/*
NOWL00005, Columbus IT, US\BBR, 07 AUG 19
  Job Planning Lines

NIGHT0001, Columbus IT, US\BBR, 01 JUN 20
  Change Matter to Billing Reference
NIGHT0006, Columbus IT, GDC\RAVU, 27 OCT 20
-Added fields "Your Reference 2"


*/

tableextension 50011 "Sales Cr.Memo Header.NOWL" extends "Sales Cr.Memo Header"
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
            DataClassification = ToBeClassified;
            Caption = 'Billing Reference Description';  // NIGHT0001  //'Matter Description';
            Editable = false;
        }
        field(50011; "Matter Description 2.NOWL"; Text[50])
        {
            Caption = 'Line Billing Reference Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50020; "Matter Contact No.NOWL"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Matter Contact No.';
            Editable = false;
        }
        field(50030; "Matter Contact Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Matter Contact Name';
            Editable = false;

        }

        field(50050; "Your Reference 2.NOWL"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Your Reference 2';

        }

    }

    var
        myInt: Integer;
}