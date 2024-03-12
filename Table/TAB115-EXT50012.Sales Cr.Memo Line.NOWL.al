tableextension 50012 "Sales Cr.Memo Line.NOWL" extends "Sales Cr.Memo Line"
{
    /*
    NOWL00005, Columbus IT, US\BBR, 07 AUG 19
      Job Planning Lines

    NIGHT0001, Columbus IT, US\BBR, 01 JUN 20
      Change Matter to Billing Reference


    NIGHT0002, Columbus IT, US\BBR, 10 JUN 20
      Billing Description

    NIGHT0006, Columbus IT, GDC\RAVU, 27 OCT 20
    -Added fields "Your Reference and Your Reference 2"

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
        field(50012; "Your Reference.NOWL"; Text[35])
        {
          Caption = 'Your Reference';
          DataClassification = CustomerContent;
        }
        field(50013;"Your Reference 2.NOWL";Text[35])
        {
          Caption = 'Your Reference 2';
          DataClassification = CustomerContent;
        }

    }

    var
        myInt: Integer;
}