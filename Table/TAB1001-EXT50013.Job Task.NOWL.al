tableextension 50013 "Job Task.NOWL" extends "Job Task"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Billing Ref. Entry No.NOWL"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Billing Reference Entry No.';    // NIGHT0001  //'Matter Entry No.';
            Editable = false;
        }
        field(50010; "Billing Ref. Description.NOWL"; Text[50])
        {
            Caption = 'Billing Reference Description';  // NIGHT0001  //'Matter Description';
            FieldClass = FlowField;
            CalcFormula = lookup ("Matter.NOWL".Description where("Entry No." = field("Billing Ref. Entry No.NOWL")));
            Editable = false;

        }

    }

    var
        myInt: Integer;
}