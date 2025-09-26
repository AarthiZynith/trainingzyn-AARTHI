table 50109 Zyn_Income
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; IncomeID; Code[10])
        {
            Caption = ' IncomeID';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(4; Date; Date)
        {
            Caption = ' Date';
            DataClassification = ToBeClassified;
        }
        field(6; CategoryName; code[100])
        {
            Caption = 'Category';
            TableRelation = Zyn_IncomeCategory.Name;
        }
    }
    keys
    {
        key(PK; IncomeID) { Clustered = true; }
    }

}
