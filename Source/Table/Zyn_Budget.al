table 50132 Zyn_Budget
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; BudgetID; code[10])
        {
            Caption = 'BudgetID';
            DataClassification = ToBeClassified;
        }
        field(2; FromDate; Date)
        {
            Caption = 'FromDate';
            DataClassification = ToBeClassified;
        }
        field(3; ToDate; Date)
        {
            Caption = 'ToDate';
            DataClassification = ToBeClassified;
        }
        field(4; CategoryName; code[100])
        {
            Caption = 'CategoryName';
            DataClassification = ToBeClassified;
            TableRelation = Zyn_ExpenseCategory;
        }
        field(5; Amount; Decimal)
        {
            Caption = 'CategoryName';
            DataClassification = ToBeClassified;
        }
        field(6; Year; Integer)
        {
            Caption = ' Year';
            DataClassification = ToBeClassified;
        }
        field(7; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; BudgetID, CategoryName)
        {
            Clustered = true;
        }
    }

}
