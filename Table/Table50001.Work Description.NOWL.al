/*
NOWL00004, Columbus IT, US\BBR, 06 AUG 19
  Additional Job Information on TimeSheets
  New Table

*/
table 50001 "Work Description.NOWL"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Work Description.NOWL";

    fields
    {
        field(10; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(20; Description; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';

        }
        field(30; Internal; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Internal';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

}