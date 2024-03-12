/*
NOWL00001, Columbus IT, US\BBR, 07 JUN 19
    Time Sheets with other Resources


NOWL00003, Columbus IT, US\BBR, 05 AUG 19
  Matter Maintenance

NOWL00004, Columbus IT, US\BBR, 06 AUG 19
  Additional Job Information on TimeSheets
  Add "Line Comment"

NOWL00005, Columbus IT, US\BBR, 07 AUG 19
  Job Planning Lines

NIGHT0001, Columbus IT, US\BBR, 01 JUN 20
  Change Matter to Billing Reference



*/

tableextension 50000 "Time Sheet Line.NOWL" extends "Time Sheet Line"
{

    fields
    {
        // Add changes to table fields here
        modify(Description)
        {
            Caption = 'Work Description';
        }
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
            TableRelation = Resource WHERE(Type = CONST(Machine));

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

        field(50008; "Matter Entry No.NOWL"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Billing Reference Entry No.';    // NIGHT0001  //'Matter Entry No.';
            Editable = false;
        }
        field(50009; "Matter Description.NOWL"; Text[50])
        {
            Caption = 'Billing Reference Description';  // NIGHT0001  //'Matter Description';
            FieldClass = FlowField;
            CalcFormula = lookup ("Matter.NOWL".Description where("Entry No." = field("Matter Entry No.NOWL")));
            Editable = false;

        }

    }
    procedure "IsPerson.NOWL"(): Boolean;
    var
        Resource: Record Resource;
        TimeSheet: Record "Time Sheet Header";
    begin
        If not TimeSheet.GET("Time Sheet No.") then
            Exit(false);
        Resource.SetRange("No.", TimeSheet."Resource No.");
        Resource.SetRange(Type, Resource.Type::Person);
        EXIT(NOT Resource.IsEmpty);
    end;

}