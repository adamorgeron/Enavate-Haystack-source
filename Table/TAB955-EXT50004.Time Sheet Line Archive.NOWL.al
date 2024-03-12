/*

NOWL00004, Columbus IT, US\BBR, 06 AUG 19
  Additional Job Information on TimeSheets
  Add "Line Comment"

*/

tableextension 50004 "Time Sheet Line Archive.NOWL" extends "Time Sheet Line Archive"
{

    fields
    {
        // Add changes to table fields here
        field(50000; "Person Time Sheet No.NOWL"; Code[20])
        {
            Caption = 'Person Time Sheet No.';

        }
        field(50001; "Person TSheet Line No.NOWL"; Integer)
        {
            Caption = 'Person Time Sheet Line No.';

        }
        field(50002; "Resource No.NOWL"; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource WHERE (Type = CONST (Machine));

        }
        field(50003; "Customer No.NOWL"; Code[20])
        {
            Caption = 'Customer No.';

        }
        field(50004; "Customer Name.NOWL"; Text[50])
        {
            Caption = 'Customer Name';

        }
        field(50005; "UOM.NOWL"; Code[10])
        {
            Caption = 'UOM';
        }
        field(50006; "Line Comment.NOWL"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Line Comment';

        }
        field(50007; "Work Description.NOWL"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Work Description';
            ObsoleteState = Removed;

        }

    }

    var
        myInt: Integer;
}