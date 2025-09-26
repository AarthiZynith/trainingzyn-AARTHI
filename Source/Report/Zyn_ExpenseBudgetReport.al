report 50151 Zyn_ExpenseVsBudgetbyYear
{
    Caption = 'Expense vs Budget by Year';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    dataset
    {
        dataitem(IntegerLoop; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 .. 12));
            trigger OnAfterGetRecord()
            var
                MonthNo: Integer;
                StartDate: Date;
                EndDate: Date;
                MonthText: Text[20];
                Category: Record Zyn_ExpenseCategory;
                ExpenseRec: Record Zyn_Expense;
                BudgetRec: Record Zyn_Budget;
                ExpenseTotal: Decimal;
                BudgetTotal: Decimal;
                FirstRow: Boolean;
                IncomeRec: Record Zyn_Income;
                IncomeTotal: Decimal;
                Savings: Decimal;
                MonthExpenseTotal: Decimal;

            begin
                MonthNo := Number;
                StartDate := DMY2Date(1, MonthNo, YearInput);
                EndDate := CalcDate('<CM>', StartDate);
                MonthText := Format(StartDate, 0, '<Month Text>');
                MonthExpenseTotal := 0;
                IncomeTotal := 0;

                // --- Loop through all categories ---
                Category.Reset();
                if Category.FindSet() then
                    repeat
                        ExpenseTotal := 0;
                        BudgetTotal := 0;

                        // --- Expense total for this category ---
                        ExpenseRec.Reset();
                        ExpenseRec.SetRange(CategoryName, Category.Name);
                        ExpenseRec.SetRange(Date, StartDate, EndDate);
                        if ExpenseRec.FindSet() then
                            repeat
                                ExpenseTotal += ExpenseRec.Amount;
                            until ExpenseRec.Next() = 0;

                        MonthExpenseTotal += ExpenseTotal; // accumulate total monthly expense

                        // --- Budget total for this category ---
                        BudgetRec.Reset();
                        BudgetRec.SetRange(CategoryName, Category.Name);
                        BudgetRec.SetRange(FromDate, StartDate, EndDate);
                        BudgetRec.SetRange(ToDate, StartDate, EndDate);
                        if BudgetRec.FindSet() then
                            repeat
                                BudgetTotal += BudgetRec.Amount;
                            until BudgetRec.Next() = 0;

                        // --- Add row for this category ---
                        AddRow(MonthText, Category.Name, ExpenseTotal, BudgetTotal);

                    until Category.Next() = 0;

                // --- Monthly Income ---
                IncomeRec.Reset();
                IncomeRec.SetRange(Date, StartDate, EndDate);
                if IncomeRec.FindSet() then
                    repeat
                        IncomeTotal += IncomeRec.Amount;
                    until IncomeRec.Next() = 0;

                // --- Savings ---
                Savings := IncomeTotal - MonthExpenseTotal;
                ExcelBuf.NewRow();
                AddRow('', 'Total Expenses', MonthExpenseTotal, 0);
                AddRow('', 'Monthly Income', IncomeTotal, 0);
                AddRow('', 'Savings', Savings, 0);
                ExcelBuf.NewRow();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field("Year"; YearInput)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Month', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Category', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Expense', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Budget', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
    end;

    trigger OnPostReport()
    begin
        filename := 'expenseData';
        ExcelBuf.CreateNewBook('Expense vs Budget');
        ExcelBuf.WriteSheet('By Year', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(filename);
        ExcelBuf.OpenExcel();

    end;

    var
        YearInput: Integer;
        ExcelBuf: Record "Excel Buffer" temporary;
        LastMonth: Text[30];
        filename: text;

    procedure AddRow(Month: Text; Category: Text; Expense: Decimal; Budget: Decimal)
    begin
        ExcelBuf.NewRow();

        if Month <> LastMonth then begin
            ExcelBuf.AddColumn(Month, false, '', false, false, false, '', 0);
            LastMonth := Month;
        end else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', 0);

        ExcelBuf.AddColumn(Category, false, '', false, false, false, '', 0);
        ExcelBuf.AddColumn(Expense, false, '', false, false, false, '', 0);
        ExcelBuf.AddColumn(Budget, false, '', false, false, false, '', 0);
    end;

}
