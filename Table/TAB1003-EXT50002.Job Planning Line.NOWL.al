tableextension 50002 "Job Planning Line.NOWL" extends "Job Planning Line"
{

    /*
        NOWL00003, Columbus IT, US\BBR, 05 AUG 19
        Matter Maintenance

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
            TableRelation = "Matter.NOWL";
            trigger OnValidate()
            var
                Matter: Record "Matter.NOWL";
            begin
                if ("Matter Entry No.NOWL" = 0) then
                    exit;
                Matter.Get("Matter Entry No.NOWL");
                "Customer No.NOWL" := Matter."Bill-to Customer No.";
            end;

        }
        field(50001; "Matter Description.NOWL"; Text[50])
        {
            Caption = 'Billing Reference Description';  // NIGHT0001  //'Matter Description';
            FieldClass = FlowField;
            CalcFormula = lookup ("Matter.NOWL".Description where("Entry No." = field("Matter Entry No.NOWL")));
            Editable = false;

        }
        field(50002; "Customer No.NOWL"; Code[20])
        {
            // NOWL00005
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(50003; "Customer Name.NOWL"; Text[50])
        {
            // NOWL00005
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup (Customer.Name where("No." = field("Customer No.NOWL")));
            Editable = false;
        }
        field(50004; "Time Sheet Resource No.NOWL"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Time Sheet Resource No.';
            Editable = false;

        }
        field(50005; "Time Sheet Resource Name.NOWL"; Text[50])
        {
            Caption = 'Time Sheet Resource Name';
            FieldClass = FlowField;
            CalcFormula = lookup (Resource.Name where("No." = field("Time Sheet Resource No.NOWL")));
            Editable = false;

        }
        field(50006; "Billing Description.NOWL"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Billing Description';
        }
        field(50007;"Your Reference.NOWL";Text[35])
        {
            Caption = 'Your Reference';
            DataClassification = CustomerContent;
            
        }
        field(50008;"Your Reference 2.NOWL";Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Your Reference 2';
        }

    }

    var
        myInt: Integer;

    trigger OnBeforeInsert()
    var
        Job: Record Job;
        "JobTask.NOWL": Record "Job Task";  // NIGHT0001
    begin
        // NIGHT0001 - change from Job to Task
        If not "JobTask.NOWL".get("Job No.", "Job Task No.") then
            job.init;
        VALIDATE("Matter Entry No.NOWL", "JobTask.NOWL"."Billing Ref. Entry No.NOWL");
    end;
}