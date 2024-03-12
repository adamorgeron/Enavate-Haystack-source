tableextension 50017 "Resource.NOWL" extends Resource
{
    /*
    NIGHT0006, Columbus IT, GDC\RAVU, 27 OCT 20
    -Added field "Billing Description"
    */
    fields
    {
        field(50000; "Billing Description.NOWL"; Text[50])
        {
            Caption = 'Billing Description';
            DataClassification = CustomerContent;
        }
    }


}