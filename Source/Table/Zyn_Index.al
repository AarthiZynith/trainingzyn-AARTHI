table 50139 Zyn_Index
{
    fields
    {
        field(1; code; code[100])
        {
            Caption = 'code';
            DataClassification = ToBeClassified;
        }
        field(2; description; text[100])
        {
            Caption = ' description';
            DataClassification = ToBeClassified;
        }
        field(3; PercentageIncrease; Decimal)
        {
            Caption = ' PercentageIncrease';
            DataClassification = ToBeClassified;
        }
        field(4; StartYear; Integer)
        {
            Caption = 'StartYear';
            DataClassification = ToBeClassified;
        }
        field(5; EndYear; Integer)
        {
            Caption = 'EndYear';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; code)
        {
            Clustered = true;
        }
    }
}