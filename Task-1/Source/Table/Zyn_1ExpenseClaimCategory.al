table 50230 Zyn_ExpenseClaimCategory
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ClaimCode; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; CategoryName; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; SubType; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; CategoryLimit; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; ClaimCode, CategoryName, SubType)
        {
            Clustered = true;
        }
    }

}