codeunit 50000 "Time Sheet Extension Mgmt.NOWL"
{
    /*
    NOWL00001, Columbus IT, US\BBR, 07 JUN 19
        Time Sheets with other Resources

    NOWL00005, Columbus IT, US\BBR, 07 AUG 19
        Job Planning Lines

    NIGHT0001, Columbus IT, US\BBR, 01 JUN 20
        Change Matter to Billing Reference

    NIGHT0002, Columbus IT, US\BBR, 10 JUN 20
    Billing Description
    Add Subscription – T_JobPlanningLine_ OnBeforeUpdateAllAmounts
    Update Subscription – C_JobCreateInvoice_OnBeforeInsertSalesLine

    NIGHT0003, Columbus IT, US\BBR, 16 JUL 20
    Gen Prod PG by Work Type
    Add Subscription - T_InvoicePostBuffer_OnAfterInvPostBufferPrepareSales

    NIGHT0006, Columbus IT, GDC\RAVU, 27 OCT 20
    -Added for updating fields "Your Reference and Your Reference 2" fields 

    NIGHT0007, Columbus IT, US\BBR, 21 DEC 20
    Gen Prod PG by Work Type Addendum
    
    NIGHT0008, Columbus IT, US\BBR, 27 JAN 21
        Changes to Job Pricing behavior

    NIGHT0011, Columbus IT, US\BBR, 04 MAR 21
    Correct field numbering on posted invoice tables to support TRANSFERFIELD behavior of base app


    */

    EventSubscriberInstance = StaticAutomatic;
    trigger OnRun()
    begin

    end;

    // Codeunit Event Subscriptions

    // NOWL00005
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', false, true)]
    local procedure C_SalesPost_OnBeforeSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    begin
        SalesHeader.CalcFields("Matter Description.NOWL", "Matter Contact Name.NOWL");
        SalesInvHeader."Matter Entry No.NOWL" := SalesHeader."Matter Entry No.NOWL";
        SalesInvHeader."Matter Description.NOWL" := SalesHeader."Matter Description.NOWL";
        SalesInvHeader."Matter Contact No.NOWL" := SalesHeader."Matter Contact No.NOWL";
        SalesInvHeader."Matter Contact Name" := SalesHeader."Matter Contact Name.NOWL";
        //SalesInvHeader."Your Reference 2.NOWL" := SalesHeader."Your Reference 2.NOWL";// NIGHT0006  // NIGHT0011 handled by TRANSFERFIELDS
    end;

    // NOWL00005
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvLineInsert', '', false, true)]
    local procedure C_SalesPost_OnBeforeSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean)
    begin
        SalesLine.CalcFields("Matter Description.NOWL");
        SalesInvLine."Matter Entry No.NOWL" := SalesLine."Matter Entry No.NOWL";
        SalesInvLine."Matter Description.NOWL" := SalesLine."Matter Description.NOWL";
        SalesInvLine."Billing Description.NOWL" := SalesLine."Billing Description.NOWL";  // NIGHT0002
        SalesInvLine."Your Reference.NOWL" := SalesLine."Your Reference.NOWL";// NIGHT0006
        //SalesInvLine."Your Reference 2.NOWL" := SalesLine."Your Reference 2.NOWL";// NIGHT0006  // NIGHT0011 - handled by TRANSFERFIELDS
    end;

    // NOWL00005
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesCrMemoHeaderInsert', '', false, true)]
    local procedure C_SalesPost_OnBeforeSalesCrMemoHeaderInsert(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    begin
        SalesHeader.CalcFields("Matter Description.NOWL", "Matter Contact Name.NOWL");
        SalesCrMemoHeader."Matter Entry No.NOWL" := SalesHeader."Matter Entry No.NOWL";
        SalesCrMemoHeader."Matter Description.NOWL" := SalesHeader."Matter Description.NOWL";
        SalesCrMemoHeader."Matter Contact No.NOWL" := SalesHeader."Matter Contact No.NOWL";
        SalesCrMemoHeader."Matter Contact Name" := SalesHeader."Matter Contact Name.NOWL";
        SalesCrMemoHeader."Your Reference 2.NOWL" := SalesHeader."Your Reference 2.NOWL";// NIGHT0006

    end;

    // NOWL00005
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesCrMemoLineInsert', '', false, true)]
    local procedure C_SalesPost_OnBeforeSalesCrMemoLineInsert(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean)
    begin
        SalesLine.CalcFields("Matter Description.NOWL");
        SalesCrMemoLine."Matter Entry No.NOWL" := SalesLine."Matter Entry No.NOWL";
        SalesCrMemoLine."Matter Description.NOWL" := SalesLine."Matter Description.NOWL";
        SalesCrMemoLine."Billing Description.NOWL" := SalesLine."Billing Description.NOWL";  // NIGHT0002
        SalesCrMemoLine."Your Reference.NOWL" := SalesLine."Your Reference.NOWL";// NIGHT0006
        SalesCrMemoLine."Your Reference 2.NOWL" := SalesLine."Your Reference 2.NOWL";// NIGHT0006
    end;

    // NIGHT0003
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostSalesLineOnAfterTestUpdatedSalesLine', '', true, false)]
    local procedure "C_SalesPost_OnPostSalesLineOnAfterTestUpdatedSalesLine.NOWL"(VAR SalesLine: Record "Sales Line"; VAR EverythingInvoiced: Boolean)
    var
        "WorkType.NOWL": Record "Work Type";
    begin
        If SalesLine.Type <> SalesLine.Type::Resource then
            exit;
        SalesLine.TestField("Work Type Code");
        "WorkType.NOWL".get(SalesLine."Work Type Code");
        "WorkType.NOWL".TestField("Gen. Prod. Posting Group.NOWL");
        SalesLine."Gen. Prod. Posting Group" := "WorkType.NOWL"."Gen. Prod. Posting Group.NOWL";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Transfer Line", 'OnAfterFromJnlLineToLedgEntry', '', false, true)]
    local procedure C_JobTransferLine_OnAfterFromJnlLineToLedgEntry(var JobLedgerEntry: Record "Job Ledger Entry"; JobJournalLine: Record "Job Journal Line")
    begin
        JobLedgerEntry.Description := JobJournalLine.Description;
        JobLedgerEntry."Line Comment.NOWL" := JobJournalLine."Line Comment.NOWL";
        // NOWL00005
        JobLedgerEntry."Customer No.NOWL" := JobJournalLine."Customer No.NOWL";
        JobLedgerEntry."Customer Name.NOWL" := JobJournalLine."Customer Name.NOWL";
        JobJournalLine.CalcFields("Matter Description.NOWL", "Time Sheet Resource Name.NOWL");
        JobLedgerEntry."Matter Entry No.NOWL" := JobJournalLine."Matter Entry No.NOWL";
        JobLedgerEntry."Matter Description.NOWL" := JobJournalLine."Matter Description.NOWL";
        JobLedgerEntry."Time Sheet Resource No.NOWL" := JobJournalLine."Time Sheet Resource No.NOWL";
        JobLedgerEntry."Time Sheet Resource Name.NOWL" := JobJournalLine."Time Sheet Resource Name.NOWL";
        JobLedgerEntry."Billing Description.NOWL" := JobJournalLine."Billing Description.NOWL";  // NIGHT0002
        JobLedgerEntry."Your Reference.NOWL" := JobJournalLine."Your Reference.NOWL";// NIGHT0006
        JobLedgerEntry."Your Reference 2.NOWL" := JobJournalLine."Your Reference 2.NOWL";// NIGHT0006
    end;

    // NOWL00005
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Transfer Line", 'OnAfterFromJobLedgEntryToPlanningLine', '', false, true)]
    local procedure C_JobTransferLine_OnAfterFromJobLedgEntryToPlanningLine(var JobPlanningLine: Record "Job Planning Line"; JobLedgEntry: Record "Job Ledger Entry")
    begin
        JobPlanningLine."Customer No.NOWL" := JobLedgEntry."Customer No.NOWL";
        JobPlanningLine."Matter Entry No.NOWL" := JobLedgEntry."Matter Entry No.NOWL";
        JobPlanningLine."Time Sheet Resource No.NOWL" := JobLedgEntry."Time Sheet Resource No.NOWL";
        JobPlanningLine."Billing Description.NOWL" := JobLedgEntry."Billing Description.NOWL";  // NIGHT0002
        JobPlanningLine."Your Reference.NOWL" := JobLedgEntry."Your Reference.NOWL";// NIGHT0006
        JobPlanningLine."Your Reference 2.NOWL" := JobLedgEntry."Your Reference 2.NOWL";// NIGHT0006
        //JobPlanningLine.Modify(TRUE);
    end;

    // NOWL00005
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnBeforeModifySalesHeader', '', false, true)]
    local procedure C_JobCreateInvoice_OnBeforeModifySalesHeader(var SalesHeader: Record "Sales Header"; Job: Record Job)
    var
        Matter: Record "Matter.NOWL";
        JobPlanningLines: Record "Job Planning Line";
    begin

        IF (Matter.get(Job."Matter Entry No.NOWL")) AND (SalesHeader."Matter Entry No.NOWL" = 0) then begin
            SalesHeader."Matter Entry No.NOWL" := Job."Matter Entry No.NOWL";
            SalesHeader."Matter Contact No.NOWL" := Matter."Bill-to Contact No.";
            SalesHeader.VALIDATE("Salesperson Code", Matter."Salesperson Code.NOWL");// NIGHT0006

        end;
        // NIGHT0006
        /*
        JobPlanningLines.SetRange("Job No.", Job."No.");
        IF NOT JobPlanningLines.IsEmpty then;
        if JobPlanningLines.FindFirst() then begin
            JobPlanningLines.CalcFields("Matter Description.NOWL");
            SalesHeader."Your Reference" := JobPlanningLines."Your Reference.NOWL";
            SalesHeader."Your Reference 2.NOWL" := JobPlanningLines."Your Reference 2.NOWL";
        end;
        */

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnAfterCreateSalesInvoiceLines', '', true, false)]
    local procedure MyProcedure(SalesHeader: Record "Sales Header"; NewInvoice: Boolean)
    var
        SalesLine: Record "Sales Line";
        Matter: Record "Matter.NOWL";

    begin

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindFirst() then begin
            SalesLine.CalcFields(SalesLine."Matter Description.NOWL");
            if SalesHeader."Matter Description 2.NOWL" <> SalesLine."Matter Description.NOWL" then;
            SalesHeader."Matter Description 2.NOWL" := SalesLine."Matter Description.NOWL";
            SalesHeader.Validate("Your Reference", SalesLine."Your Reference.NOWL");
            SalesHeader.Validate("Your Reference 2.NOWL", SalesLine."Your Reference 2.NOWL");
            SalesHeader."Matter Entry No.NOWL" := SalesLine."Matter Entry No.NOWL";
            IF Matter.get(SalesLine."Matter Entry No.NOWL") then
                SalesHeader.Validate("Salesperson Code", Matter."Salesperson Code.NOWL");
            SalesHeader.Modify();
        end;
    end;


    // NOWL00005
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnBeforeInsertSalesLine', '', false, true)]
    local procedure C_JobCreateInvoice_OnBeforeInsertSalesLine(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; Job: Record Job; JobPlanningLine: Record "Job Planning Line")
    begin
        SalesLine."Matter Entry No.NOWL" := JobPlanningLine."Matter Entry No.NOWL";
        SalesLine."Billing Description.NOWL" := JobPlanningLine."Billing Description.NOWL"; // NIGHT0002
        // NIGHT0006
        SalesLine."Matter Description.NOWL" := JobPlanningLine."Matter Description.NOWL";
        SalesLine."Your Reference.NOWL" := JobPlanningLine."Your Reference.NOWL";
        SalesLine."Your Reference 2.NOWL" := JobPlanningLine."Your Reference 2.NOWL";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Time Sheet Management", 'OnBeforeToTimeSheetLineInsert', '', false, true)]
    local procedure C_TimeSheetManagement_OnBeforeToTimeSheetLineInsert(var ToTimeSheetLine: Record "Time Sheet Line"; FromTimeSheetLine: Record "Time Sheet Line")
    begin

    end;

    // Page Event Subscriptions

    // NIGHT0001
    [EventSubscriber(ObjectType::Page, Page::"Job Journal", 'OnAfterValidateEvent', 'Job Task No.', false, true)]
    local procedure P_JobJournal_OnAfterValidate_JobTaskNo(VAR Rec: Record "Job Journal Line"; VAR xRec: Record "Job Journal Line")
    begin
        with Rec do begin
            CalcFields("Matter Description.NOWL");
        end;
    end;

    [EventSubscriber(ObjectType::Page, 50000, 'OnNewRecordEvent', '', false, false)]
    local procedure P_TimeSheetSubPage_OnNewRecordEvent(var Rec: Record "Time Sheet Line"; BelowxRec: Boolean; var xRec: Record "Time Sheet Line")
    begin
        WITH Rec do begin
            FilterGroup(4);
            //IF GetFilter(Type) > '' THEN
            IF Evaluate(Type, GetFilter(Type)) THEN;
            FilterGroup(0);
        end;
    end;


    [EventSubscriber(ObjectType::Page, 50000, 'OnInsertRecordEvent', '', false, false)]
    local procedure P_TimeSheetSubPage_OnInsertRecordEvent(var Rec: Record "Time Sheet Line"; BelowxRec: Boolean; var xRec: Record "Time Sheet Line")
    var
        PersonTimeLine: Record "Time Sheet Line";
        TimeSheet: Record "Time Sheet Header";
        TimeSheetLine: Record "Time Sheet Line";
        NextLine: Integer;
        PersonTimeSheet: Record "Time Sheet Header";
    begin
        WITH Rec do begin
            FilterGroup(4);
            //Evaluate(Type, GetFilter(Type));
            //"Person Time Sheet No.NOWL" := GetFilter("Person Time Sheet No.NOWL");
            //Evaluate("Person TSheet Line No.NOWL", GetFilter("Person TSheet Line No.NOWL"));
            "Job No." := GetFilter("Job No.");
            "Job Task No." := GetFilter("Job Task No.");
            PersonTimeLine.Get("Person Time Sheet No.NOWL", "Person TSheet Line No.NOWL");
            "Customer No.NOWL" := PersonTimeLine."Customer No.NOWL";
            "Customer Name.NOWL" := PersonTimeLine."Customer Name.NOWL";
            PersonTimeSheet.Get("Person Time Sheet No.NOWL");
            FilterGroup(0);
            TimeSheet.LockTable();
            TimeSheet.SetRange("Resource No.", "Resource No.NOWL");
            TimeSheet.SetRange("Starting Date", PersonTimeSheet."Starting Date");
            TimeSheet.SetRange("Ending Date", PersonTimeSheet."Ending Date");
            IF TimeSheet.FindLast() then begin
                TimeSheetLine.Reset();
                TimeSheetLine.SetRange("Time Sheet No.", TimeSheet."No.");
                IF TimeSheetLine.FindLast() then
                    NextLine := TimeSheetLine."Line No." + 10000
                else
                    NextLine := 10000;
                "Line No." := NextLine;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, 950, 'OnInsertRecordEvent', '', false, false)]
    local procedure P_TimeSheet_OnInsertRecordEvent(var Rec: Record "Time Sheet Line"; BelowxRec: Boolean; var xRec: Record "Time Sheet Line")
    var
        PersonTimeLine: Record "Time Sheet Line";
    begin
        WITH Rec do begin
        end;
    end;

    // Table Event Subscriptions

    [EventSubscriber(ObjectType::Table, Database::Job, 'OnBeforeInsertEvent', '', false, true)]
    local procedure T_Job_OnBeforeInsertEvent(var Rec: Record Job; RunTrigger: Boolean)
    begin
        with Rec do begin
            //Blocked := Blocked::All; // NIGHT0001 - removed
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Job, 'OnAfterValidateEvent', 'Matter Entry No.NOWL', false, true)]
    local procedure T_Job_OnAfterValidateEvent_MatterEntryNo(var Rec: Record Job; var xRec: Record Job; CurrFieldNo: Integer)
    begin
        with Rec do begin
            // NIGHT0001 - removed
            /*
            Case true of
                (Rec."Matter Entry No.NOWL" > 0) and (xRec."Matter Entry No.NOWL" = 0):
                    Blocked := Blocked::" ";
            end;
            */
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Job, 'OnAfterValidateEvent', 'Blocked', false, true)]
    local procedure T_Job_OnAfterValidateEvent_Blocked(var Rec: Record Job; var xRec: Record Job; CurrFieldNo: Integer)
    begin
        with Rec do begin
            // NIGHT0001 - removed
            /*
            if (Blocked = Blocked::" ") then
                TestField("Matter Entry No.NOWL");
            */
        end;
    end;

    // NIGHT0001
    [EventSubscriber(ObjectType::Table, Database::"Job Journal Line", 'OnAfterValidateEvent', 'Job No.', false, false)]
    local procedure T_JobJournalLine_OnAfterValidateEvent_JobNo(VAR Rec: Record "Job Journal Line")
    var
        "Job.NOWL": Record "Job";
    begin
        With Rec DO begin
            If not "Job.NOWL".get("Job No.") then
                "Job.NOWL".init;
            "Customer No.NOWL" := "Job.NOWL"."Bill-to Customer No.";
            "Customer Name.NOWL" := "Job.NOWL"."Bill-to Name";
            //if "Line No." > 0 then
            //    Modify();
        end;
    end;


    // NIGHT0001
    [EventSubscriber(ObjectType::Table, Database::"Job Journal Line", 'OnAfterValidateEvent', 'Job Task No.', false, false)]
    local procedure T_JobJournalLine_OnAfterValidateEvent_JobTaskNo(VAR Rec: Record "Job Journal Line")
    var
        "JobTask.NOWL": Record "Job Task";
    begin
        With Rec DO begin
            If not "JobTask.NOWL".get("Job No.", "Job Task No.") then
                "JobTask.NOWL".init;
            "Matter Entry No.NOWL" := "JobTask.NOWL"."Billing Ref. Entry No.NOWL";
            //if "Line No." > 0 then
            //    Modify();
        end;
    end;

    // NIGHT0002
    [EventSubscriber(ObjectType::Table, Database::"Job Journal Line", 'OnBeforeUpdateAllAmounts', '', true, false)]
    local procedure T_JobJournalLine_OnBeforeUpdateAllAmounts(VAR JobJournalLine: Record "Job Journal Line"; xJobJournalLine: Record "Job Journal Line")
    begin
        with JobJournalLine DO Begin
            //if "Billing Description.NOWL" > '' then  // NIGHT0008 - removed
            //    exit;
            "JobJournalLine_UpdateBillingDesc.NOWL"(JobJournalLine);

        End;
    end;

    // NIGHT0002
    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", 'OnBeforeUpdateAllAmounts', '', TRUE, false)]
    local procedure T_JobPlanningLine_OnBeforeUpdateAllAmounts(VAR JobPlanningLine: Record "Job Planning Line")
    var
        Found: Boolean;
    begin
        With JobPlanningLine do begin
            //if "Billing Description.NOWL" > '' then  // NIGHT0008 - removed
            //    exit;
            "JobPlanningLine_UpdateBillingDesc.NOWL"(JobPlanningLine);
        End;
    end;

    //NIGHT0006
    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", 'OnAfterValidateEvent', 'Job Task No.', TRUE, false)]
    local procedure T_JobPlanningLine_JobTaskNoOnAfterValidate(var Rec: Record "Job Planning Line"; var xRec: Record "Job Planning Line")
    var
        JobtaskLines: Record "Job Task";
        Matter: Record "Matter.NOWL";
    begin
        if JobtaskLines.Get(Rec."Job No.", Rec."Job Task No.") then;
        if Matter.Get(JobtaskLines."Billing Ref. Entry No.NOWL") then;
        Rec."Your Reference.NOWL" := Matter."Your Reference.NOWL";
        Rec."Your Reference 2.NOWL" := Matter."Your Reference 2.NOWL";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Time Sheet Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure T_TimeSheetLine_OnAfterDeleteEvent(VAR Rec: Record "Time Sheet Line"; RunTrigger: Boolean)
    var
        MachineTimeLine: Record "Time Sheet Line";
    begin
        With Rec DO begin
            MachineTimeLine.Reset;
            MachineTimeLine.SetRange("Person Time Sheet No.NOWL", "Time Sheet No.");
            MachineTimeLine.SetRange("Person TSheet Line No.NOWL", "Line No.");
            MachineTimeLine.DeleteAll(TRUE);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Time Sheet Line", 'OnAfterValidateEvent', 'Job No.', false, false)]
    local procedure T_TimeSheetLine_JobNo_OnAfterValidate(var Rec: Record "Time Sheet Line")
    var
        Job: Record Job;
    Begin
        WITH Rec DO begin
            Job.get("Job No.");
            "Customer No.NOWL" := Job."Bill-to Customer No.";
            "Customer Name.NOWL" := Job."Bill-to Name";
            //"Matter Entry No.NOWL" := Job."Matter Entry No.NOWL";  // NIGHT0001 - moved to task
            //CalcFields("Matter Description.NOWL");  // NIGHT0001
            //Modify;                                 // NIGHT0001
        end;
    End;

    [EventSubscriber(ObjectType::Table, Database::"Time Sheet Line", 'OnAfterValidateEvent', 'Job Task No.', false, false)]
    local procedure T_TimeSheetLine_JobTaskNo_OnAfterValidate(var Rec: Record "Time Sheet Line")
    var
        "JobTask.NOWL": Record "Job Task";
    Begin
        WITH Rec DO begin
            Description := '';
            If not "JobTask.NOWL".get("Job No.", "Job Task No.") then
                "JobTask.NOWL".init;
            "Matter Entry No.NOWL" := "JobTask.NOWL"."Billing Ref. Entry No.NOWL";
            CalcFields("Matter Description.NOWL");
            //Modify();  // NIGHT0001
        end;
    End;

    [EventSubscriber(ObjectType::Table, Database::"Time Sheet Line", 'OnAfterValidateEvent', 'Resource No.NOWL', false, false)]
    local procedure T_TimeSheetLine_ResourceNo_OnAfterValidate(var Rec: Record "Time Sheet Line")
    var
        Resource: Record Resource;
        TimeSheet: Record "Time Sheet Header";
        TimeSheetLine: Record "Time Sheet Line";
        PersonTimeSheet: Record "Time Sheet Header";
        NextLine: Integer;
    Begin
        WITH Rec do begin
            //TestField(Type, Type::Resource);
            //FilterGroup(4);
            PersonTimeSheet.Get("Person Time Sheet No.NOWL");
            //FilterGroup(0);
            Resource.RESET;
            Resource.SetRange(Type, Type::Resource);
            Resource.SetRange("No.", "Resource No.NOWL");
            IF Resource.IsEmpty then
                Error('%1 %2 does not exist', FieldCaption("Resource No.NOWL"), "Resource No.NOWL");

            TimeSheet.Reset();
            TimeSheet.SetRange("Resource No.", "Resource No.NOWL");
            TimeSheet.SetRange("Starting Date", PersonTimeSheet."Starting Date");
            TimeSheet.SetRange("Ending Date", PersonTimeSheet."Ending Date");
            IF TimeSheet.FindLast() then begin
                "Time Sheet No." := TimeSheet."No.";
                //TimeSheetLine.Reset();
                //TimeSheetLine.SetRange("Time Sheet No.", TimeSheet."No.");
                //IF TimeSheetLine.FindLast() then
                //    NextLine := TimeSheetLine."Line No." + 10000
                //else
                //    NextLine := 10000;
                //"Time Sheet No." := TimeSheet."No.";
                //"Line No." := NextLine;
            end else
                Error('%1 does not exist for %2 %3 for %4 thru %5', TimeSheet.TableCaption, FieldCaption("Resource No.NOWL"), "Resource No.NOWL", PersonTimeSheet."Starting Date", PersonTimeSheet."Ending Date");
        end;
    End;

    [EventSubscriber(ObjectType::Table, Database::"Time Sheet Detail", 'OnBeforeInsertEvent', '', false, true)]
    local procedure T_TimeSheetDetail_OnBeforeInsertEvent(var Rec: Record "Time Sheet Detail"; RunTrigger: Boolean)
    begin
        With Rec do begin
            if RunTrigger then
                CheckMinimumTimeEntry(Rec);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Time Sheet Detail", 'OnBeforeModifyEvent', '', false, true)]
    local procedure T_TimeSheetDetail_OnBeforeModifyEvent(var Rec: Record "Time Sheet Detail"; var xRec: Record "Time Sheet Detail"; RunTrigger: Boolean)
    begin
        With Rec do begin
            if RunTrigger then
                CheckMinimumTimeEntry(Rec);
        end;
    end;
    // NIGHT0006
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Transfer Line", 'OnAfterFromPlanningLineToJnlLine', '', false, true)]
    local procedure C_JobTransferLine_OnAfterFromPlanningLineToJnlLine(var JobJournalLine: Record "Job Journal Line"; JobPlanningLine: Record "Job Planning Line")
    begin
        JobJournalLine."Your Reference.NOWL" := JobPlanningLine."Your Reference.NOWL";
        JobJournalLine."Your Reference 2.NOWL" := JobPlanningLine."Your Reference 2.NOWL";

    end;

    // Report Event Subscriptions

    [EventSubscriber(ObjectType::Report, Report::"Suggest Job Jnl. Lines", 'OnAfterTransferTimeSheetDetailToJobJnlLine', '', false, true)]
    local procedure R_SuggestJobJnlLines_OnAfterTransferTimeSheetDetailToJobJnlLine(var JobJournalLine: Record "Job Journal Line"; JobJournalTemplate: Record "Job Journal Template"; var TempTimeSheetLine: Record "Time Sheet Line"; TimeSheetDetail: Record "Time Sheet Detail")
    var
        TimeSheet: Record "Time Sheet Header";
        "JobPlanningLine.NOWL": Record "Job Planning Line";
    begin
        JobJournalLine.Description := TempTimeSheetLine.Description;
        JobJournalLine."Line Comment.NOWL" := TempTimeSheetLine."Line Comment.NOWL";
        // NOWL00005
        JobJournalLine."Customer No.NOWL" := TempTimeSheetLine."Customer No.NOWL";
        JobJournalLine."Customer Name.NOWL" := TempTimeSheetLine."Customer Name.NOWL";
        JobJournalLine."Matter Entry No.NOWL" := TempTimeSheetLine."Matter Entry No.NOWL";
        JobJournalLine.CalcFields("Matter Description.NOWL");
        TimeSheet.GET(TempTimeSheetLine."Time Sheet No.");
        JobJournalLine."Time Sheet Resource No.NOWL" := TimeSheet."Resource No.";
        If TempTimeSheetLine.Chargeable then
            JobJournalLine."Line Type" := JobJournalLine."Line Type"::Billable;
        // NIGHT0002
        "JobPlanningLine.NOWL".Init();
        "JobPlanningLine.NOWL"."Job No." := JobJournalLine."Job No.";
        "JobPlanningLine.NOWL"."Currency Code" := JobJournalLine."Currency Code";
        "JobPlanningLine.NOWL"."Job Task No." := JobJournalLine."Job Task No.";
        "JobPlanningLine.NOWL".Type := JobJournalLine.Type;
        "JobPlanningLine.NOWL"."No." := JobJournalLine."No.";
        "JobPlanningLine.NOWL"."Work Type Code" := JobJournalLine."Work Type Code";
        "JobPlanningLine_UpdateBillingDesc.NOWL"("JobPlanningLine.NOWL");
        JobJournalLine."Billing Description.NOWL" := "JobPlanningLine.NOWL"."Billing Description.NOWL";
        "JobPlanningLine.NOWL"."Your Reference.NOWL" := JobJournalLine."Your Reference.NOWL";// NIGHT0006
        "JobPlanningLine.NOWL"."Your Reference 2.NOWL" := JobJournalLine."Your Reference 2.NOWL";// NIGHT0006

    end;

    // local procedures
    local procedure CheckMinimumTimeEntry(var TimeSheetDetail: Record "Time Sheet Detail")
    var
        Customer: Record Customer;
        Resource: Record Resource;
        TimeSheet: Record "Time Sheet Header";
        TimeSheetLine: Record "Time Sheet Line";
        Partial: Decimal;
        QtyToCheck: Decimal;
    begin
        QtyToCheck := TimeSheetDetail.Quantity;
        if QtyToCheck = 0 then
            exit;
        if not TimeSheet.get(TimeSheetDetail."Time Sheet No.") then
            exit;
        if not TimeSheetLine.get(TimeSheetDetail."Time Sheet No.", TimeSheetDetail."Time Sheet Line No.") then
            exit;
        if not Resource.get(TimeSheet."Resource No.") then
            exit;
        if Resource.Type <> Resource.Type::Person then
            exit;
        if not Customer.get(TimeSheetLine."Customer No.NOWL") then
            exit;
        if Customer."Minimum Hours.NOWL" = 0 then
            exit;
        if QtyToCheck < Customer."Minimum Hours.NOWL" then
            QtyToCheck := Customer."Minimum Hours.NOWL";
        if Customer."Hours Multiplier.NOWL" > 0 then begin
            Partial := QtyToCheck MOD Customer."Hours Multiplier.NOWL";
            If Partial > 0 then
                QtyToCheck := QtyToCheck + (Customer."Hours Multiplier.NOWL" - Partial);
        end;
        If QtyToCheck <> TimeSheetDetail.Quantity then
            TimeSheetDetail.Quantity := QtyToCheck;

    end;

    // NIGHT0002
    local procedure "JobPlanningLine_UpdateBillingDesc.NOWL"(VAR "JobPlanningLine.NOWL": Record "Job Planning Line")
    var
        "JobResourcePrice.NOWL": Record "Job Resource Price";
        "JobGLPrice.NOWL": Record "Job G/L Account Price";
        "Resource.NOWL": Record Resource;
        "WorkType.NOWL": Record "Work Type";  // NIGHT0008
    begin
        WITH "JobPlanningLine.NOWL" DO
            CASE Type OF
                Type::Resource:
                    BEGIN
                        "Resource.NOWL".GET("No.");
                        "JobResourcePrice.NOWL".SETRANGE("Job No.", "Job No.");
                        "JobResourcePrice.NOWL".SETRANGE("Currency Code", "Currency Code");
                        "JobResourcePrice.NOWL".SETRANGE("Job Task No.", "Job Task No.");
                        CASE TRUE OF
                            "JobPlanningLineFindJobResPrice.NOWL"("JobPlanningLine.NOWL", "JobResourcePrice.NOWL", "JobResourcePrice.NOWL".Type::Resource):
                                "JobPlanningLine.NOWL"."Billing Description.NOWL" := "JobResourcePrice.NOWL"."Billing Description.NOWL";
                            "JobPlanningLineFindJobResPrice.NOWL"("JobPlanningLine.NOWL", "JobResourcePrice.NOWL", "JobResourcePrice.NOWL".Type::"Group(Resource)"):
                                "JobPlanningLine.NOWL"."Billing Description.NOWL" := "JobResourcePrice.NOWL"."Billing Description.NOWL";
                            "JobPlanningLineFindJobResPrice.NOWL"("JobPlanningLine.NOWL", "JobResourcePrice.NOWL", "JobResourcePrice.NOWL".Type::All):
                                "JobPlanningLine.NOWL"."Billing Description.NOWL" := "JobResourcePrice.NOWL"."Billing Description.NOWL";
                            ELSE BEGIN
                                "JobResourcePrice.NOWL".SETRANGE("Job Task No.", '');
                                CASE TRUE OF
                                    "JobPlanningLineFindJobResPrice.NOWL"("JobPlanningLine.NOWL", "JobResourcePrice.NOWL", "JobResourcePrice.NOWL".Type::Resource):
                                        "JobPlanningLine.NOWL"."Billing Description.NOWL" := "JobResourcePrice.NOWL"."Billing Description.NOWL";
                                    "JobPlanningLineFindJobResPrice.NOWL"("JobPlanningLine.NOWL", "JobResourcePrice.NOWL", "JobResourcePrice.NOWL".Type::"Group(Resource)"):
                                        "JobPlanningLine.NOWL"."Billing Description.NOWL" := "JobResourcePrice.NOWL"."Billing Description.NOWL";
                                    "JobPlanningLineFindJobResPrice.NOWL"("JobPlanningLine.NOWL", "JobResourcePrice.NOWL", "JobResourcePrice.NOWL".Type::All):
                                        "JobPlanningLine.NOWL"."Billing Description.NOWL" := "JobResourcePrice.NOWL"."Billing Description.NOWL";
                                    else begin  // NIGHT0008
                                        if "WorkType.NOWL".get("JobPlanningLine.NOWL"."Work Type Code") then
                                            "JobPlanningLine.NOWL"."Billing Description.NOWL" := "WorkType.NOWL".Description
                                        else
                                            "JobPlanningLine.NOWL"."Billing Description.NOWL" := "Resource.NOWL"."Billing Description.NOWL";//NIGHT0006
                                    end;
                                END;
                            END;

                        END

                    END;
                Type::"G/L Account":
                    BEGIN
                        "JobGLPrice.NOWL".SETRANGE("Job No.", "Job No.");
                        "JobGLPrice.NOWL".SETRANGE("G/L Account No.", "No.");
                        "JobGLPrice.NOWL".SETRANGE("Currency Code", "Currency Code");
                        "JobGLPrice.NOWL".SETRANGE("Job Task No.", "Job Task No.");
                        IF "JobGLPrice.NOWL".FINDFIRST THEN
                            "JobPlanningLine.NOWL"."Billing Description.NOWL" := "JobGLPrice.NOWL"."Billing Description.NOWL"
                        ELSE BEGIN
                            "JobGLPrice.NOWL".SETRANGE("Job Task No.", '');
                            IF "JobGLPrice.NOWL".FINDFIRST THEN;
                            "JobPlanningLine.NOWL"."Billing Description.NOWL" := "JobGLPrice.NOWL"."Billing Description.NOWL";
                        END;
                    END;
            END;

    end;

    // NIGHT0002
    local procedure "FindJobResPrice.NOWL"(VAR "JobResPrice.NOWL": Record "Job Resource Price"; "WorkTypeCode.NOWL": Code[10]): Boolean
    var
        myInt: Integer;
    begin
        "JobResPrice.NOWL".SETRANGE("Work Type Code", "WorkTypeCode.NOWL");
        IF "JobResPrice.NOWL".FINDFIRST THEN
            EXIT(TRUE);
        "JobResPrice.NOWL".SETRANGE("Work Type Code", '');
        EXIT("JobResPrice.NOWL".FINDFIRST);
    end;

    // NIGHT0002
    // PriceType
    // 0 = Resource
    // 1 = Group
    // 2 = All
    local procedure "JobPlanningLineFindJobResPrice.NOWL"(VAR "JobPlanningLine.NOWL": Record "Job Planning Line"; VAR "JobResPrice.NOWL": Record "Job Resource Price"; "PriceType.NOWL": Integer): Boolean
    var
        "Resource.NOWL": Record Resource;
    begin
        "Resource.NOWL".GET("JobPlanningLine.NOWL"."No.");
        CASE "PriceType.NOWL" OF
            0:
                BEGIN
                    "JobResPrice.NOWL".SETRANGE(Type, "JobResPrice.NOWL".Type::Resource);
                    "JobResPrice.NOWL".SETRANGE("Work Type Code", "JobPlanningLine.NOWL"."Work Type Code");
                    "JobResPrice.NOWL".SETRANGE(Code, "JobPlanningLine.NOWL"."No.");
                    EXIT("JobResPrice.NOWL".FIND('-'));
                END;
            1:
                BEGIN
                    "JobResPrice.NOWL".SETRANGE(Type, "JobResPrice.NOWL".Type::"Group(Resource)");
                    "JobResPrice.NOWL".SETRANGE(Code, "Resource.NOWL"."Resource Group No.");
                    EXIT("FindJobResPrice.NOWL"("JobResPrice.NOWL", "JobPlanningLine.NOWL"."Work Type Code"));
                END;
            2:
                BEGIN
                    "JobResPrice.NOWL".SETRANGE(Type, "JobResPrice.NOWL".Type::All);
                    "JobResPrice.NOWL".SETRANGE(Code);
                    EXIT("FindJobResPrice.NOWL"("JobResPrice.NOWL", "JobPlanningLine.NOWL"."Work Type Code"));
                END;
        end;
    end;

    local procedure "JobJournalLineFindJobResPrice.NOWL"(VAR "JobJournalLine.NOWL": Record "Job Journal Line"; VAR "JobResPrice.NOWL": Record "Job Resource Price"; "PriceType.NOWL": Integer): Boolean
    var
        "Resource.NOWL": Record Resource;
    begin
        "Resource.NOWL".GET("JobJournalLine.NOWL"."No.");
        CASE "PriceType.NOWL" OF
            0:
                BEGIN
                    "JobResPrice.NOWL".SETRANGE(Type, "JobResPrice.NOWL".Type::Resource);
                    "JobResPrice.NOWL".SETRANGE("Work Type Code", "JobJournalLine.NOWL"."Work Type Code");
                    "JobResPrice.NOWL".SETRANGE(Code, "JobJournalLine.NOWL"."No.");
                    EXIT("JobResPrice.NOWL".FIND('-'));
                END;
            1:
                BEGIN
                    "JobResPrice.NOWL".SETRANGE(Type, "JobResPrice.NOWL".Type::"Group(Resource)");
                    "JobResPrice.NOWL".SETRANGE(Code, "Resource.NOWL"."Resource Group No.");
                    EXIT("FindJobResPrice.NOWL"("JobResPrice.NOWL", "JobJournalLine.NOWL"."Work Type Code"));
                END;
            2:
                BEGIN
                    "JobResPrice.NOWL".SETRANGE(Type, "JobResPrice.NOWL".Type::All);
                    "JobResPrice.NOWL".SETRANGE(Code);
                    EXIT("FindJobResPrice.NOWL"("JobResPrice.NOWL", "JobJournalLine.NOWL"."Work Type Code"));
                END;
        end;
    end;

    // NIGHT0002
    local procedure "JobJournalLine_UpdateBillingDesc.NOWL"(VAR "JobJournalLine.NOWL": Record "Job Journal Line")
    var
        "JobResourcePrice.NOWL": Record "Job Resource Price";
        "JobGLPrice.NOWL": Record "Job G/L Account Price";
        "Resource.NOWL": Record Resource;
    begin
        WITH "JobJournalLine.NOWL" DO
            CASE Type OF
                Type::Resource:
                    BEGIN
                        "Resource.NOWL".GET("No.");
                        "JobResourcePrice.NOWL".SETRANGE("Job No.", "Job No.");
                        "JobResourcePrice.NOWL".SETRANGE("Currency Code", "Currency Code");
                        "JobResourcePrice.NOWL".SETRANGE("Job Task No.", "Job Task No.");
                        CASE TRUE OF
                            "JobJournalLineFindJobResPrice.NOWL"("JobJournalLine.NOWL", "JobResourcePrice.NOWL", "JobResourcePrice.NOWL".Type::Resource):
                                "JobJournalLine.NOWL"."Billing Description.NOWL" := "JobResourcePrice.NOWL"."Billing Description.NOWL";
                            "JobJournalLineFindJobResPrice.NOWL"("JobJournalLine.NOWL", "JobResourcePrice.NOWL", "JobResourcePrice.NOWL".Type::"Group(Resource)"):
                                "JobJournalLine.NOWL"."Billing Description.NOWL" := "JobResourcePrice.NOWL"."Billing Description.NOWL";
                            "JobJournalLineFindJobResPrice.NOWL"("JobJournalLine.NOWL", "JobResourcePrice.NOWL", "JobResourcePrice.NOWL".Type::All):
                                "JobJournalLine.NOWL"."Billing Description.NOWL" := "JobResourcePrice.NOWL"."Billing Description.NOWL";
                            ELSE BEGIN
                                "JobResourcePrice.NOWL".SETRANGE("Job Task No.", '');
                                CASE TRUE OF
                                    "JobJournalLineFindJobResPrice.NOWL"("JobJournalLine.NOWL", "JobResourcePrice.NOWL", "JobResourcePrice.NOWL".Type::Resource):
                                        "JobJournalLine.NOWL"."Billing Description.NOWL" := "JobResourcePrice.NOWL"."Billing Description.NOWL";
                                    "JobJournalLineFindJobResPrice.NOWL"("JobJournalLine.NOWL", "JobResourcePrice.NOWL", "JobResourcePrice.NOWL".Type::"Group(Resource)"):
                                        "JobJournalLine.NOWL"."Billing Description.NOWL" := "JobResourcePrice.NOWL"."Billing Description.NOWL";
                                    "JobJournalLineFindJobResPrice.NOWL"("JobJournalLine.NOWL", "JobResourcePrice.NOWL", "JobResourcePrice.NOWL".Type::All):
                                        "JobJournalLine.NOWL"."Billing Description.NOWL" := "JobResourcePrice.NOWL"."Billing Description.NOWL";
                                    else
                                        "JobJournalLine.NOWL"."Billing Description.NOWL" := "Resource.NOWL"."Billing Description.NOWL";//NIGHT0006
                                END;
                            END;
                        END;
                    END;
                Type::"G/L Account":
                    BEGIN
                        "JobGLPrice.NOWL".SETRANGE("Job No.", "Job No.");
                        "JobGLPrice.NOWL".SETRANGE("G/L Account No.", "No.");
                        "JobGLPrice.NOWL".SETRANGE("Currency Code", "Currency Code");
                        "JobGLPrice.NOWL".SETRANGE("Job Task No.", "Job Task No.");
                        IF "JobGLPrice.NOWL".FINDFIRST THEN
                            "JobJournalLine.NOWL"."Billing Description.NOWL" := "JobGLPrice.NOWL"."Billing Description.NOWL"
                        ELSE BEGIN
                            "JobGLPrice.NOWL".SETRANGE("Job Task No.", '');
                            IF "JobGLPrice.NOWL".FINDFIRST THEN;
                            "JobJournalLine.NOWL"."Billing Description.NOWL" := "JobGLPrice.NOWL"."Billing Description.NOWL";
                        END;
                    END;
            END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Post-Line", 'OnBeforeValidateRelationship', '', true, true)]
    local procedure "C_JobPostLine_OnBeforeValidateRelationship.NOWL"
    (
        var SalesHeader: Record "Sales Header";
        var SalesLine: Record "Sales Line";
        var JobPlanningLine: Record "Job Planning Line";
        var IsHandled: Boolean
    )
    var
        "WorkType.NOWL": Record "Work Type";
    begin
        If SalesLine.Type <> SalesLine.Type::Resource then
            exit;
        if SalesLine."Gen. Prod. Posting Group" = JobPlanningLine."Gen. Prod. Posting Group" then
            exit;
        SalesLine.TestField("Work Type Code", JobPlanningLine."Work Type Code");
        "WorkType.NOWL".get(SalesLine."Work Type Code");
        "WorkType.NOWL".TestField("Gen. Prod. Posting Group.NOWL", SalesLine."Gen. Prod. Posting Group");
        JobPlanningLine."Gen. Prod. Posting Group" := "WorkType.NOWL"."Gen. Prod. Posting Group.NOWL";
    end;


    var
        myInt: Integer;
}