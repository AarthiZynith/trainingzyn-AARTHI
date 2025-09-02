table 50112 HighestSalesPrice
{
    fields
    {
        field(1; "Customer No"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Item No"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Item Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Posting date"; Date)
        {
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