tableextension 50015 "Job G/L Account Price.NOWL" extends "Job G/L Account Price"
{
    /*
        NIGHT0002, Columbus IT, US\BBR, 10 JUN 20
        Billing Description

    */

    fields
    {
        // Add changes to table fields here
        field(50000; "Billing Description.NOWL"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Billing Description';
        }

    }

    var
        myInt: Integer;
}