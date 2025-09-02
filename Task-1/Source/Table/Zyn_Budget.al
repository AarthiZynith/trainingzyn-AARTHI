table 50132 Budget
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; BudgetID; code[10])
        {
            DataClassification = ToBeClassified;
           // AutoIncrement = true;

        }
        field(2; FromDate; Date)
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // begin
            //     // Default to first day of current month
            //     if "FromDate" = 0D then
            //         "FromDate" := DMY2Date(1, Date2DMY(WORKDATE,2), Date2DMY(WORKDATE,3));
            // end;
        }
        field(3; ToDate; Date)
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // begin
            //     // Default to last day of current month
            //     if "ToDate" = 0D then
            //         "ToDate" := CalcDate('<CM>', WORKDATE);
            // end;
        }
        field(4; CategoryName; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation=ExpenseCategory;
            
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }



        field(6; Year;Integer){
            DataClassification=ToBeClassified;
        }
        field(7;Month;Integer){
            DataClassification=ToBeClassified;
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
