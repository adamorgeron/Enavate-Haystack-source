report 50099 "Update Sales Invoices.NOWL"
{
    /*
    NIGHT0011, Columbus IT, US\BBR, 04 MAR 21
    Correct field numbering on posted invoice tables to support TRANSFERFIELD behavior of base app


    */
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Update Sales Invoices for Your Reference 2';
    ProcessingOnly = true;
    Permissions = tabledata 112 = rm, tabledata 113 = rm;
    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(number) where(number = const(1));
            trigger OnAfterGetRecord()
            var
                "InvoiceHeader.NOWL": Record "Sales Invoice Header";
                "InvoiceLine.NOWL": Record "Sales Invoice Line";
                "InvoiceHeader2.NOWL": Record "Sales Invoice Header";
                "InvoiceLine2.NOWL": Record "Sales Invoice Line";
                "RecCount.NOWL": Integer;
            begin
                Window.Open(Text004);
                if "InvoiceHeader.NOWL".FindSet() then
                    repeat
                        "RecCount.NOWL" += 1;
                        Window.Update(1, FORMAT("RecCount.NOWL"));
                        "InvoiceHeader2.NOWL" := "InvoiceHeader.NOWL";
                        "InvoiceHeader2.NOWL"."Your Reference 3.NOWL" := "InvoiceHeader2.NOWL"."Your Reference 2.NOWL";
                        "InvoiceHeader2.NOWL".Modify();
                    until "InvoiceHeader.NOWL".Next() = 0;
                Window.Close();
                "RecCount.NOWL" := 0;
                Window.Open(Text005);
                If "InvoiceLine.NOWL".FindSet() then
                    repeat
                        "RecCount.NOWL" += 1;
                        Window.Update(1, FORMAT("RecCount.NOWL"));
                        "InvoiceLine2.NOWL" := "InvoiceLine.NOWL";
                        "InvoiceLine2.NOWL"."Your Reference 3.NOWL" := "InvoiceLine2.NOWL"."Your Reference 2.NOWL";
                        "InvoiceLine2.NOWL".Modify();
                    until "InvoiceLine.NOWL".Next() = 0;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()
    begin
        if not Confirm(Text001) then
            Error(Text002);
    end;

    trigger OnPostReport()
    begin
        Window.Close();
        Message(Text003);
    end;

    var
        myInt: Integer;
        Window: Dialog;
        Text001: Label 'Begin Processing?';
        Text002: Label 'Aborted by User';
        Text003: Label 'Processing Complete';
        Text004: Label 'Processing Invoice Headers- Please Wait - #1###############';
        Text005: Label 'Processing Invoice Lines- Please Wait - #1###############';
}