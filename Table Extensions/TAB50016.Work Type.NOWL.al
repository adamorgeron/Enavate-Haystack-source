tableextension 50016 "Work Type.NOWL" extends "Work Type"
{
    /*
    NIGHT0003, Columbus IT, US\BBR, 16 JUL 20
    Gen Prod PG by Work Type

    */
    fields
    {
        // Add changes to table fields here
        field(50000; "Gen. Prod. Posting Group.NOWL"; Code[20])  // NIGHT0003
        {
            DataClassification = ToBeClassified;
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
    }

    var
        myInt: Integer;
}