tableextension 50005 "Job Journal Line.NOWL" extends "Job Journal Line"
{
    /*

        NOWL00004, Columbus IT, US\BBR, 06 AUG 19
        Additional Job Information on TimeSheets
        Add "Line Comment"

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
        field(50000; "Line Comment.NOWL"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Line Comment';
            Editable = false;

        }
        field(50001; "Work Description.NOWL"; Text[100])



        {
            DataClassification = ToBeClassified;
            Caption = 'Work Description';
            ObsoleteState = Removed;
        }
        field(50003; "Customer No.NOWL"; Code[20])
        {
            Caption = 'Customer No.';
            Editable = false;

        }
        field(50004; "Customer Name.NOWL"; Text[50])
        {
            Caption = 'Customer Name';
            Editable = false;

        }
        field(50005; "Matter Entry No.NOWL"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Billing Reference Entry No.';    // NIGHT0001  //'Matter Entry No.';
            Editable = false;
        }
        field(50006; "Matter Description.NOWL"; Text[50])
        {
            Caption = 'Billing Reference Description';  // NIGHT0001  //'Matter Description';
            FieldClass = FlowField;
            CalcFormula = lookup ("Matter.NOWL".Description where("Entry No." = field("Matter Entry No.NOWL")));
            Editable = false;

        }
        field(50007; "Time Sheet Resource No.NOWL"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Time Sheet Resource No.';
            Editable = false;

        }
        field(50008; "Time Sheet Resource Name.NOWL"; Text[50])
        {
            Caption = 'Time Sheet Resource Name';
            FieldClass = FlowField;
            CalcFormula = lookup (Resource.Name where("No." = field("Time Sheet Resource No.NOWL")));
            Editable = false;

        }
        field(50011; "Billing Description.NOWL"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Billing Description';
        }
        field(50015;"Your Reference.NOWL";Text[35])
        {
            DataClassification =CustomerContent;
            Caption = 'Your Reference';
        }
        field(50020; "Your Reference 2.NOWL";Text[35])
        {
            Caption = 'Your Reference 2';
            DataClassification = CustomerContent;
        }



    }

}