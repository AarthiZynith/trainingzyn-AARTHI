// report 50151 "Expense vs Budget by Year"
// {
//     Caption = 'Expense vs Budget by Year';
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     ProcessingOnly = true;

//     dataset
//     {
//         // You don’t need heavy dataset logic,
//         // everything will be handled in the procedure
//         dataitem(Category; ExpenseCategory)
//         {
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(Options)
//                 {
//                     field("Year"; YearInput)
//                     {
//                         ApplicationArea = All;
//                     }
//                 }
//             }
//         }
//     }

//     trigger OnPostReport()
//     begin
//         ExportCategoryBudgetExpensePerMonth(); // <-- call procedure here
//     end;

//     trigger OnPreReport()
//     begin
//         if YearInput = 0 then
//             YearInput := Date2DMY(WorkDate(), 3); // default current year
//     end;

//     var
//         YearInput: Integer;

//     local procedure ExportCategoryBudgetExpensePerMonth()
//     var
//         CategoryRec: Record ExpenseCategory;
//         ExpenseRec: Record Expense;
//         BudgetRec: Record Budget;
//         ExcelBuffer: Record "Excel Buffer" temporary;
//         MonthNo: Integer;
//         StartDate: Date;
//         EndDate: Date;
//         MonthBudget: Decimal;
//         MonthExpense: Decimal;
//     begin
//         Clear(ExcelBuffer);
//         ExcelBuffer.DeleteAll();

//         // ---- Column headers ----
//         ExcelBuffer.NewRow();
//         ExcelBuffer.AddColumn('Category', true, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);

//         for MonthNo := 1 to 12 do begin
//             ExcelBuffer.AddColumn(Format(DMY2Date(1, MonthNo, YearInput), 0, '<Month Text>') + ' Budget',
//                 true, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
//             ExcelBuffer.AddColumn(Format(DMY2Date(1, MonthNo, YearInput), 0, '<Month Text>') + ' Expense',
//                 true, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
//         end;

//         // ---- Loop categories ----
//         if CategoryRec.FindSet() then
//             repeat
//                 ExcelBuffer.NewRow();
//                 ExcelBuffer.AddColumn(CategoryRec.Name, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);

//                 for MonthNo := 1 to 12 do begin
//                     StartDate := DMY2Date(1, MonthNo, YearInput);
//                     EndDate := CalcDate('<CM>', StartDate); // last day of month

//                     // --- Budget ---
//                     MonthBudget := 0;
//                     BudgetRec.Reset();
//                     BudgetRec.SetRange(CategoryName, CategoryRec.Name);
//                     BudgetRec.SetRange(FromDate, StartDate, EndDate);
//                     if BudgetRec.FindSet() then
//                         repeat
//                             MonthBudget += BudgetRec.Amount;
//                         until BudgetRec.Next() = 0;

//                     // --- Expense ---
//                     MonthExpense := 0;
//                     ExpenseRec.Reset();
//                     ExpenseRec.SetRange(CategoryName, CategoryRec.Name);
//                     ExpenseRec.SetRange("Date", StartDate, EndDate);
//                     if ExpenseRec.FindSet() then
//                         repeat
//                             MonthExpense += ExpenseRec.Amount;
//                         until ExpenseRec.Next() = 0;

//                     // --- Export values ---
//                     ExcelBuffer.AddColumn(MonthBudget, false, '', true, false, true, '', ExcelBuffer."Cell Type"::Number);
//                     ExcelBuffer.AddColumn(MonthExpense, false, '', true, false, true, '', ExcelBuffer."Cell Type"::Number);
//                 end;
//             until CategoryRec.Next() = 0;

//         // ---- Create Excel ----
//         ExcelBuffer.CreateNewBook('Category Budget vs Expense');
//         ExcelBuffer.WriteSheet('Monthly Data', CompanyName, UserId);
//         ExcelBuffer.CloseBook();
//         ExcelBuffer.OpenExcel();
//     end;
// }


// 


report 50151 "Expense vs Budget by Year"
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
                Category: Record ExpenseCategory;
                ExpenseRec: Record Expense;
                BudgetRec: Record Budget;
                ExpenseTotal: Decimal;
                BudgetTotal: Decimal;
                FirstRow: Boolean;
                IncomeRec: Record Income;
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

                //     if FirstRow then begin
                //         ExcelBuf.AddColumn(MonthText, false, '', false, false, false, '', 0);
                //         FirstRow := false;
                //     end else
                //         ExcelBuf.AddColumn('', false, '', false, false, false, '', 0);

                //     // --- Write Row ---
                //     ExcelBuf.NewRow();
                //     ExcelBuf.AddColumn(MonthText, false, '', false, false, false, '', 0);
                //     ExcelBuf.AddColumn(Category.Name, false, '', false, false, false, '', 0);
                //     ExcelBuf.AddColumn(ExpenseTotal, false, '', false, false, false, '', 0);
                //     ExcelBuf.AddColumn(BudgetTotal, false, '', false, false, false, '', 0);

                // until Category.Next() = 0;
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
        // Write headers before any data
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
        LastMonth: Text[30]; // <-- variable for AddRow
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
