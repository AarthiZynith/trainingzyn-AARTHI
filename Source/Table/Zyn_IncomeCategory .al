table 50113 Zyn_IncomeCategory
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Name; Code[100])
        {
            Caption = ' Name';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            Caption = ' Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Current Month Total"; Decimal)
        {
            Caption = 'Current Month Total';
            FieldClass = FlowField;
            CalcFormula = Sum(Zyn_Income.Amount WHERE(CategoryName = FIELD(Name), Date = FILTER('<CM>')));
            Editable = false;
        }
        field(4; "Current Quarter Total"; Decimal)
        {
            Caption = 'Current Quarter Total';
            FieldClass = FlowField;
            CalcFormula = Sum(Zyn_Income.Amount WHERE(CategoryName = FIELD(Name), Date = FILTER('<-CQ>' .. '<CQ>')));
            Editable = false;
        }
        field(5; "Current Half-Year Total"; Decimal)
        {
            Caption = 'Current Half-Year Total';
            FieldClass = FlowField;
            CalcFormula = Sum(Zyn_Income.Amount WHERE(CategoryName = FIELD(Name), Date = FILTER(('<-6M>' .. '<CD>'))));
            Editable = false;
        }
        field(6; "Current Year Total"; Decimal)
        {
            Caption = 'Current Year Total';
            FieldClass = FlowField;
            CalcFormula = Sum(Zyn_Income.Amount WHERE(CategoryName = FIELD(Name), Date = FILTER('<-CY>' .. '<CY>')));
            Editable = false;
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
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
