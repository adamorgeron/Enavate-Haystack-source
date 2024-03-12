page 50002 "Time Sheet Subpage 2.NOWL"
{
    /*
    NOWL00001, Columbus IT, US\BBR, 07 JUN 19
        Time Sheets with other Resources

    */

    PageType = ListPart;
    SourceTable = "Time Sheet Line";
    SourceTableView = where ("Person Time Sheet No.NOWL" = FILTER (> ''));
    Caption = 'Time Sheet Subpage 2';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Type; Type)
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Resource No.NOWL"; "Resource No.NOWL")
                {
                    ApplicationArea = All;

                }
                field("UOM.NOWL"; "UOM.NOWL")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;

                }
                field(Field1; CellData[1])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + ColumnCaption[1];

                }
                field(Field2; CellData[2])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + ColumnCaption[2];

                }
                field(Field3; CellData[3])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + ColumnCaption[3];

                }
                field(Field4; CellData[4])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + ColumnCaption[4];

                }
                field(Field5; CellData[5])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + ColumnCaption[5];

                }
                field(Field6; CellData[6])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + ColumnCaption[6];

                }
                field(Field7; CellData[7])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + ColumnCaption[7];

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

    procedure SetPersonTimeSheetHeader(PersonTimeNo: Code[20])
    begin
        IF NOT PersonTimeSheetHeader.GET(PersonTimeNo) then
            PersonTimeSheetHeader.INIT;
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

    local procedure CellDataOnAfterValidate()
    begin
        CALCFIELDS("Total Quantity");
    end;

    trigger OnAfterGetRecord()
    begin
        AfterGetCurrentRecord;
    end;


    trigger OnFindRecord(Which: Text): Boolean
    begin
        /*
        FilterGroup(4);
        IF PersonTimeSheetHeader."No." <> GetFilter("Person Time Sheet No.NOWL") THEN
            IF PersonTimeSheetHeader.GET(GetFilter("Person Time Sheet No.NOWL")) THEN;
        FilterGroup(0);
        */
        UpdateControls();
        EXIT(FIND(Which));
    end;


}