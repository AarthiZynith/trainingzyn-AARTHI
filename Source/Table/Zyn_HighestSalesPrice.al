table 50112 Zyn_HighestSalesPrice
{
    fields
    {
        field(1; "Customer No"; code[100])
        {
            Caption = 'Customer No';
            DataClassification = ToBeClassified;
        }
        field(2; "Item No"; code[100])
        {
            Caption = 'Item No';
            DataClassification = ToBeClassified;
        }
        field(3; "Item Price"; Decimal)
        {
            Caption = 'Item Price';
            DataClassification = ToBeClassified;
        }
        field(4; "Posting date"; Date)
        {
            Caption = 'Posting date';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Customer No", "Item No")
        {
            Clustered = true;

        }
    }
}