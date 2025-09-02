table 50116 ExpenseCategory
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Name; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        // FlowFields for totals
        field(3; "Current Month Total"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum(Expense.Amount WHERE(CategoryName = FIELD(Name), Date = FILTER('<CM>')));
            Editable = false;

        }

        field(4; "Current Quarter Total"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum(Expense.Amount WHERE(CategoryName = FIELD(Name), Date = FILTER('<-CQ>' .. '<CQ>')));
            Editable = false;

        }

        field(5; "Current Half-Year Total"; Decimal)
        {
            FieldClass = FlowField;

            CalcFormula = Sum(Expense.Amount WHERE(CategoryName = FIELD(Name), Date = FILTER(('<-6M>' .. '<CD>'))));
            Editable = false;
        }

        field(6; "Current Year Total"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum(Expense.Amount WHERE(CategoryName = FIELD(Name), Date = FILTER('<-CY>' .. '<CY>')));
            Editable = false;

        }
        field(7;Date;Date){
            DataClassification=ToBeClassified;
        }
        field(8;RemBudget;Decimal){
            DataClassification=ToBeClassified;
        }
    }

    keys
    {
        key(PK; Name)
        {
            Clustered = true;
        }
    }
}
