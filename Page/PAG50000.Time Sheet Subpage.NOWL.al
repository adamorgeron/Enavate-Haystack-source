page 50000 "Time Sheet Subpage.NOWL"
{
    /*
    NOWL00001, Columbus IT, US\BBR, 07 JUN 19
        Time Sheets with other Resources

    */

    PageType = ListPart;
    SourceTable = "Time Sheet Line";
    SourceTableView = where ("Person Time Sheet No.NOWL" = FILTER (> ''));
    Caption = 'Time Sheet Subpage';
    Editable = true;
    AutoSplitKey = false;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Type; Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;

                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;

                }
                field("Resource No.NOWL"; "Resource No.NOWL")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        Resource: Record Resource;
                    begin
                        IF "Resource No.NOWL" > '' THEN begin
                            Resource.Get("Resource No.NOWL");
                            "UOM.NOWL" := Resource."Base Unit of Measure";
                        end;
                    end;

                }
                field("UOM.NOWL"; "UOM.NOWL")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    trigger OnValidate();
                    begin
                        CurrPage.SAVERECORD;
                    end;

                }
                field(Field1; CellData[1])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + ColumnCaption[1];
                    trigger OnValidate();
                    begin
                        CurrPage.SAVERECORD;
                        ValidateQuantity(1);
                        CellDataOnAfterValidate;
                    end;

                }
                field(Field2; CellData[2])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + ColumnCaption[2];
                    trigger OnValidate();
                    begin
                        CurrPage.SAVERECORD;
                        ValidateQuantity(2);
                        CellDataOnAfterValidate;
                    end;

                }
                field(Field3; CellData[3])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + ColumnCaption[3];
                    trigger OnValidate();
                    begin
                        CurrPage.SAVERECORD;
                        ValidateQuantity(3);
                        CellDataOnAfterValidate;
                    end;

                }
                field(Field4; CellData[4])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + ColumnCaption[4];
                    trigger OnValidate();
                    begin
                        CurrPage.SAVERECORD;
                        ValidateQuantity(4);
                        CellDataOnAfterValidate;
                    end;

                }
                field(Field5; CellData[5])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + ColumnCaption[5];
                    trigger OnValidate();
                    begin
                        CurrPage.SAVERECORD;
                        ValidateQuantity(5);
                        CellDataOnAfterValidate;
                    end;

                }
                field(Field6; CellData[6])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + ColumnCaption[6];
                    trigger OnValidate();
                    begin
                        CurrPage.SAVERECORD;
                        ValidateQuantity(6);
                        CellDataOnAfterValidate;
                    end;

                }
                field(Field7; CellData[7])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + ColumnCaption[7];
                    trigger OnValidate();
                    begin
                        CurrPage.SAVERECORD;
                        ValidateQuantity(7);
                        CellDataOnAfterValidate;
                    end;

                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    var
        CellData: ARRAY[32] OF Decimal;
        TimeSheetMgt: Codeunit "Time Sheet Management";
        TimeSheetHeader: Record "Time Sheet Header";
        TimeSheetDetail: Record "Time Sheet Detail";
        ColumnRecords: array[32] OF Record Date;
        NoOfColumns: Integer;
        ColumnCaption: array[32] of Text[1024];
        CurrTimeSheetNo: Code[20];
        AllowEdit: Boolean;
        PersonTimeSheetHeader: Record "Time Sheet Header";
        PersonTimeSheetLineNo: Integer;

    procedure UpdateControls()
    begin
        SetColumns;
        CurrPage.UPDATE(FALSE);
    end;

    procedure SetColumns()
    var
        Calendar: Record Date;
    begin
        CLEAR(ColumnCaption);
        CLEAR(ColumnRecords);
        CLEAR(Calendar);
        CLEAR(NoOfColumns);
        //IF CurrTimeSheetNo = '' then
        //    Exit;

        //PersonTimeSheetHeader.GET(CurrTimeSheetNo);
        Calendar.SETRANGE("Period Type", Calendar."Period Type"::Date);
        Calendar.SETRANGE("Period Start", PersonTimeSheetHeader."Starting Date", PersonTimeSheetHeader."Ending Date");
        IF Calendar.FINDSET THEN
            REPEAT
                NoOfColumns += 1;
                ColumnRecords[NoOfColumns]."Period Start" := Calendar."Period Start";
                ColumnCaption[NoOfColumns] := TimeSheetMgt.FormatDate(Calendar."Period Start", 1);
            UNTIL Calendar.NEXT = 0;
    end;

    procedure SetPersonTimeSheetHeader(PersonTimeNo: Code[20]; LineNo: Integer)
    begin
        PersonTimeSheetHeader.GET(PersonTimeNo);
        PersonTimeSheetLineNo := LineNo;
    end;

    local procedure AfterGetCurrentRecord()
    var
        i: Integer;
    begin
        i := 0;
        WHILE i < NoOfColumns DO BEGIN
            i := i + 1;
            IF ("Line No." <> 0) AND TimeSheetDetail.GET(
                "Time Sheet No.",
                "Line No.",
                ColumnRecords[i]."Period Start")
            THEN
                CellData[i] := TimeSheetDetail.Quantity
            ELSE
                CellData[i] := 0;
        END;
        AllowEdit := Status IN [Status::Open, Status::Rejected];
    end;

    local procedure TestTimeSheetLineStatus()
    var
        TimeSheetLine: Record "Time Sheet Line";
    begin
        TimeSheetLine.GET("Time Sheet No.", "Line No.");
        TimeSheetLine.TestStatus;
    end;

    local procedure ValidateQuantity(ColumnNo: Integer)
    begin
        IF (CellData[ColumnNo] <> 0) AND (Type = Type::" ") THEN
            ERROR('The type of time sheet line cannot be empty.');

        IF TimeSheetDetail.GET(
            "Time Sheet No.",
            "Line No.",
            ColumnRecords[ColumnNo]."Period Start")
        THEN BEGIN
            IF CellData[ColumnNo] <> TimeSheetDetail.Quantity THEN
                TestTimeSheetLineStatus;

            IF CellData[ColumnNo] = 0 THEN
                TimeSheetDetail.DELETE
            ELSE BEGIN
                TimeSheetDetail.Quantity := CellData[ColumnNo];
                TimeSheetDetail.MODIFY(TRUE);
            END;
        END ELSE
            IF CellData[ColumnNo] <> 0 THEN BEGIN
                TestTimeSheetLineStatus;

                TimeSheetDetail.INIT;
                TimeSheetDetail.CopyFromTimeSheetLine(Rec);
                TimeSheetDetail.Date := ColumnRecords[ColumnNo]."Period Start";
                TimeSheetDetail.Quantity := CellData[ColumnNo];
                TimeSheetDetail.INSERT(TRUE);
            END;
    end;

    local procedure CellDataOnAfterValidate()
    begin
        CALCFIELDS("Total Quantity");
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        ResourceTimeHeader: Record "Time Sheet Header";
        ResourceTimeLine: Record "Time Sheet Line";
    begin
        ResourceTimeHeader.Reset();
        ResourceTimeHeader.SetRange("Resource No.", "Resource No.NOWL");

    end;

    trigger OnAfterGetRecord()
    begin
        /*
        FilterGroup(4);
        IF PersonTimeSheetHeader."No." <> GetFilter("Person Time Sheet No.NOWL") THEN
            PersonTimeSheetHeader.GET(GetFilter("Person Time Sheet No.NOWL"));
        FilterGroup(0);
        UpdateControls();
        */
        AfterGetCurrentRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*
        FilterGroup(4);
        IF PersonTimeSheetHeader."No." <> GetFilter("Person Time Sheet No.NOWL") THEN
            PersonTimeSheetHeader.GET(GetFilter("Person Time Sheet No.NOWL"));
        FilterGroup(0);
        UpdateControls();
        */
        "Person Time Sheet No.NOWL" := PersonTimeSheetHeader."No.";
        "Person TSheet Line No.NOWL" := PersonTimeSheetLineNo;
        AfterGetCurrentRecord;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        FilterGroup(4);
        //IF PersonTimeSheetHeader."No." <> GetFilter("Person Time Sheet No.NOWL") THEN
        //    IF PersonTimeSheetHeader.GET(GetFilter("Person Time Sheet No.NOWL")) THEN;
        FilterGroup(0);
        UpdateControls();
        EXIT(FIND(Which));
    end;


}