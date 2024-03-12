/*
NOWL00005, Columbus IT, US\BBR, 07 AUG 19
  Job Planning Lines

NIGHT0001, Columbus IT, US\BBR, 01 JUN 20
  Change Matter to Billing Reference
  
NIGHT0006, Columbus IT, GDC\RAVU, 27 OCT 20
-Added fields "Your Reference and Your Reference 2"

NIGHT0011, Columbus IT, US\BBR, 04 MAR 21
  Correct field numbering on posted invoice tables to support TRANSFERFIELD behavior of base app

*/

tableextension 50009 "Sales Invoice Header.NOWL" extends "Sales Invoice Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Matter Entry No.NOWL"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Billing Reference Entry No.';    // NIGHT0001  //'Matter Entry No.';
            Editable = true;
        }
        field(50010; "Matter Description.NOWL"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Billing Reference Description';  // NIGHT0001  //'Matter Description';
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
        field(50040; "Your Reference 2.NOWL"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'old Your Reference 2';  // NIGHT0011 - caption changed to avoid confusion with replacement field
            ObsoleteState = Pending;  // NIGHT0011
            ObsoleteReason = 'Replaced by field 50050 to support TRANSFERFIELDS';  // NIGHT0011
        }
        field(50011; "Matter Description 2.NOWL"; Text[50])
        {
            Caption = 'Line Billing Reference Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        // NIGHT0011 - new field to replace 50040 'Your Reference 2.NOWL'
        field(50050; "Your Reference 3.NOWL"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Your Reference 2';
        }

    }

    var
        myInt: Integer;
}