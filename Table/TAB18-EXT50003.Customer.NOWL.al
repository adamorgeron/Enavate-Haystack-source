/*
NOWL00004, Columbus IT, US\BBR, 06 AUG 19
  Additional Job Information on TimeSheets
  New Table

*/
tableextension 50003 "Customer.NOWL" extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Minimum Hours.NOWL"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Minimum Hours';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }
        field(50001; "Hours Multiplier.NOWL"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Hours Multiplier';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }

    }

    var
        myInt: Integer;
}