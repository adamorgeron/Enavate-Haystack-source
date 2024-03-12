
/*
NOWL00003, Columbus IT, US\BBR, 05 AUG 19
  Matter Maintenance

NIGHT0001, Columbus IT, US\BBR, 01 JUN 20
  Change Matter to Billing Reference


*/

tableextension 50001 "Job.NOWL" extends Job
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Matter Entry No.NOWL"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Billing Reference Entry No.';    // NIGHT0001  //'Matter Entry No.';
            TableRelation = "Matter.NOWL";
            trigger OnValidate()
            var
                JobPlanninLine: Record "Job Planning Line";
                JobJnlLine: Record "Job Journal Line";
                JobLedgerEntry: Record "Job Ledger Entry";
                TimeSheetLine: Record "Time Sheet Line";
            begin
                if (xRec."Matter Entry No.NOWL" > 0) and ("Matter Entry No.NOWL" <> xRec."Matter Entry No.NOWL") then begin
                    JobLedgerEntry.SetRange("Job No.", "No.");
                    if not JobLedgerEntry.IsEmpty then
                        error(StrSubstNo(Text001, JobLedgerEntry.FieldCaption("Job No."), "No.", FieldCaption("Matter Description.NOWL")));


                end;

                CalcFields("Matter Description.NOWL");
                JobPlanninLine.SetRange("Job No.", "No.");
                JobPlanninLine.ModifyAll("Matter Entry No.NOWL", "Matter Entry No.NOWL");
            End;
        }
        field(50001; "Matter Description.NOWL"; Text[50])
        {
            Caption = 'Billing Reference Description';  // NIGHT0001  //'Matter Description';
            FieldClass = FlowField;
            CalcFormula = lookup ("Matter.NOWL".Description where("Entry No." = field("Matter Entry No.NOWL")));
            Editable = false;

        }
    }

    keys
    {
        key(NOWL1; "Matter Entry No.NOWL")
        {

        }
    }
    var
        myInt: Integer;
        Text001: Label '%1 %2 has posted entries.  %3 may not be chnaged';
}