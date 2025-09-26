table 50114 Zyn_Expense
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ExpenseID; Code[10])
        {
            Caption = ' ExpenseID';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            Caption = ' Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Remaining Budget"; Decimal)

        {
            Caption = 'Remaining Budget';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; Amount; Decimal)
        {
            Caption = ' Amount';
            DataClassification = ToBeClassified;
        }
        field(5; Date; Date)
        {
            Caption = ' Date';
            DataClassification = ToBeClassified;
        }
        field(7; CategoryName; code[100]) // always show name
        {
            Caption = 'Category';
            TableRelation = Zyn_ExpenseCategory.Name;
            trigger OnValidate()
            var
                ExpenseBudget: Record Zyn_Expense;
                TotalBudget: Decimal;
                budget: Record Zyn_Budget;
                StartD: Date;
                EndD: Date;
            begin
                StartD := CalcDate('<-CM>', WorkDate); // 1st day of current year
                EndD := CalcDate('<CM>', WorkDate);         // last day of current year
                ExpenseBudget.Reset();
                ExpenseBudget.SetRange(CategoryName, rec.CategoryName);
                ExpenseBudget.SetRange(Date, StartD, EndD);

                if ExpenseBudget.FindSet() then
                    repeat
                        TotalBudget += ExpenseBudget.Amount;
                    until ExpenseBudget.Next() = 0;
                budget.Reset();
                budget.SetRange(FromDate, StartD);
                budget.SetRange(ToDate, EndD);
                budget.SetRange(CategoryName, Rec.CategoryName);
                if budget.FindFirst() then
                    Rec."Remaining Budget" := budget.Amount - TotalBudget
                else
                    rec."Remaining Budget" -= TotalBudget;
            end;
        }
    }
    keys
    {
        key(PK; ExpenseID) { Clustered = true; }
    }

    trigger OnInsert()
    var
        Expense: Record Zyn_Expense;
        Lastid: Integer;
    begin
        if "ExpenseID" = '' then begin
            if expense.FindLast() then
                Evaluate(lastid, CopyStr(expense."ExpenseID", 4))
            else
                lastid := 0;
            Lastid += 1;
            "ExpenseID" := 'EXP' + PadStr(Format(lastid), 3, '0');
        end;
    end;
}
