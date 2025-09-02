table 50114 Expense
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ExpenseID; Code[10]) { DataClassification = ToBeClassified; }
        field(2; Description; Text[100]) { DataClassification = ToBeClassified; }
        field(3; "Remaining Budget"; Decimal)
       
        { DataClassification=ToBeClassified;
            Editable=false;
            // FieldClass = FlowField;
            // CalcFormula = lookup(Budget.Amount WHERE(ExpenseCategory = FIELD(CategoryNo)))
            //               - sum(Expense.Amount WHERE (CategoryNo = FIELD(CategoryNo)));
        }
        field(4; Amount; Decimal) { DataClassification = ToBeClassified; }
        field(5; Date; Date) { DataClassification = ToBeClassified; }

        // field(5; CategoryNo; Integer) // store only the key
        // {
        //     Caption = 'Category No';
        //     TableRelation = ExpenseCategory.CategoryNo;
        // }

        field(7; CategoryName; code[100]) // always show name
        {
            Caption = 'Category';
            TableRelation = ExpenseCategory.Name;
            trigger OnValidate()
            var
                ExpenseBudget: Record Expense;
                TotalBudget: Decimal;
                budget: Record Budget;
                StartD: Date;
                EndD:Date;
            begin
                StartD := CalcDate('<-CM>', WorkDate); // 1st day of current year
                EndD := CalcDate('<CM>', WorkDate);         // last day of current year
                ExpenseBudget.Reset();
                ExpenseBudget.SetRange(CategoryName,rec.CategoryName);
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
                    Rec."Remaining Budget":= budget.Amount - TotalBudget
                else
                    rec."Remaining Budget" -= TotalBudget;

                //exit(TotalBudget);
            end;


            //     FieldClass = FlowField;
            //     CalcFormula = Lookup(ExpenseCategory.Name WHERE(CategoryNo = FIELD(CategoryNo)));
            //    // Editable = false;
            // }
        }
    }
    keys
    {
        key(PK; ExpenseID) { Clustered = true; }
    }



trigger OnInsert()
    var
        Expense: Record Expense;
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
