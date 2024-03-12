tableextension 50010 "Sales Invoice Line.NOWL" extends "Sales Invoice Line"
{
    /*
      NOWL00005, Columbus IT, US\BBR, 07 AUG 19
        Job Planning Lines

      NOWL00006, Columbus IT, US\BBR, 13 AUG 19
        Invoice Custom Report

      NIGHT0001, Columbus IT, US\BBR, 01 JUN 20
        Change Matter to Billing Reference

      NIGHT0002, Columbus IT, US\BBR, 10 JUN 20
        Billing Description

      NIGHT0011, Columbus IT, US\BBR, 04 MAR 21
        Correct field numbering on posted invoice tables to support TRANSFERFIELD behavior of base app


    */

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
        field(50011; "Billing Description.NOWL"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Billing Description';
        }

        // NOWL00006 - Temp use only
        field(50020; "Resource Group Code.NOWL"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Resource Group Code';
        }
        field(50030; "Your Reference.NOWL"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Your Reference';
        }
        field(50040; "Your Reference 2.NOWL"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Old Your Reference 2';  // NIGHT0011 - caption changed to avoid confusion with replacement field
            ObsoleteState = Pending;  // NIGHT0011
            ObsoleteReason = 'Replaced by field 50013 to support TRANSFERFIELDS';  // NIGHT0011
        }
        field(50050; "Inv Comment Desc.NOWL"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Inv Comment Desc';   // NIGHT0011 - 'Your Reference 2';
        }
        // NIGHT0011
        field(50013; "Your Reference 3.NOWL"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Your Reference 2';
        }

    }

    var
        myInt: Integer;
}