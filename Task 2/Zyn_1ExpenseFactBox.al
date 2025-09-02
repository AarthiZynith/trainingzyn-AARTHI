// page 50119 "Expense Totals FactBox"
// {
//     PageType = CardPart;
//     SourceTable =ExpenseCategory;
//     ApplicationArea = All;
//     Caption = 'Category Expense Info';
 
//     layout
//     {
//         area(content)
//         {
//             cuegroup("Expense Category Expense Info")
//             {
//                 field("Expense Current Year"; ExpenseCurrentYear)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Current Year';
//                     DrillDown = true;
 
//                     trigger OnDrillDown()
//                     var
//                         Expense: Record Expense;
//                         StartD: Date;
//                         EndD: Date;
//                     begin
//                         GetCYRange(StartD, EndD);
//                         Expense.SetRange(CategoryName, rec.Name);
//                         Expense.SetRange(Date, StartD, EndD);
//                         PAGE.Run(PAGE::ExpenseListPage, Expense);
//                     end;
//                 }
 
//                 field("Expense Current Month"; ExpenseCurrentMonth)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Current Month';
//                     DrillDown = true;
 
//                     trigger OnDrillDown()
//                     var
//                         Expense: Record Expense;
//                         StartD: Date;
//                         EndD: Date;
//                     begin
//                         GetCMRange(StartD, EndD);
//                         Expense.SetRange(CategoryName, Rec.Name);
//                         Expense.SetRange(Date, StartD, EndD);
//                         PAGE.Run(PAGE::ExpenseListPage, Expense);
//                     end;
//                 }
 
//                 field("Expense Current Quarter"; ExpenseCurrentQuarter)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Current Quarter';
//                     DrillDown = true;
 
//                     trigger OnDrillDown()
//                     var
//                         Expense: Record Expense;
//                         StartD: Date;
//                         EndD: Date;
//                     begin
//                         GetCQRange(StartD, EndD);
//                         Expense.SetRange(CategoryName, Rec.Name);
//                         Expense.SetRange(Date, StartD, EndD);
//                         PAGE.Run(PAGE::ExpenseListPage, Expense);
//                     end;
//                 }
 
//                 field("Expense Current Half Year"; ExpenseCurrentHalfYear)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Current Half-Year';
//                     DrillDown = true;
 
//                     trigger OnDrillDown()
//                     var
//                         Expense: Record Expense;
//                         StartD: Date;
//                         EndD: Date;
//                     begin
//                         GetHalfYearRange(StartD, EndD);
//                         Expense.SetRange(CategoryName, Rec.Name);
//                         Expense.SetRange(Date, StartD, EndD);
//                         PAGE.Run(PAGE::ExpenseListPage, Expense);
//                     end;
//                 }
 
//                 field("Expense Current Year Budget"; ExpenseCurrentYearBudget)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Current Year Budget';
//                     ToolTip = 'The budgeted amount for the current year in this category.';
//                     DrillDown = true;
 
//                     trigger OnDrillDown()
//                     var
//                         ExpenseBudget: Record Budget;
//                         StartD: Date;
//                         EndD: Date;
//                     begin
//                         GetCYRange(StartD, EndD);
//                         ExpenseBudget.SetRange(CategoryName, Rec.Name);
//                         ExpenseBudget.SetRange(FromDate, StartD, EndD);
//                         PAGE.Run(PAGE::BudgetCard, ExpenseBudget);
//                     end;
//                 }
//                 field(RemainingBudget; RemainingBudget)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Remaining Budget';
//                 }
//             }
//         }
//     }
 
//     trigger OnAfterGetRecord()
//     var
//         Expense: Record Expense;
//         StartD: Date;
//         EndD: Date;
//     begin
//         // Current Year
//         GetCYRange(StartD, EndD);
//         Expense.SetRange( CategoryName, Rec.Name);
//         Expense.SetRange(date, StartD, EndD);
//         Expense.CalcSums(Amount);
//         ExpenseCurrentYear := Expense.Amount;
 
//         // Current Month
//         GetCMRange(StartD, EndD);
//         Expense.SetRange(Date, StartD, EndD);
//         Expense.CalcSums(Amount);
//         ExpenseCurrentMonth := Expense.Amount;
 
//         // Current Quarter
//         GetCQRange(StartD, EndD);
//         Expense.SetRange(Date, StartD, EndD);
//         Expense.CalcSums(Amount);
//         ExpenseCurrentQuarter := Expense.Amount;
 
//         // Current Half-Year
//         GetHalfYearRange(StartD, EndD);
//         Expense.SetRange(Date, StartD, EndD);
//         Expense.CalcSums(Amount);
//         ExpenseCurrentHalfYear := Expense.Amount;
 
//         // Current Year Budget
//         ExpenseCurrentYearBudget := GetCurrentYearBudget(Rec.Name);
 
//         RemainingBudget := ExpenseCurrentYearBudget - ExpenseCurrentYear;
//     end;
 
//     var
//         ExpenseCurrentYear: Decimal;
//         ExpenseCurrentMonth: Decimal;
//         ExpenseCurrentQuarter: Decimal;
//         ExpenseCurrentHalfYear: Decimal;
//         ExpenseCurrentYearBudget: Decimal;
//         RemainingBudget: Decimal;
 
//     // ------------------ Local Procedures ------------------
 
//     local procedure GetCYRange(var StartDate: Date; var EndDate: Date)
//     begin
//         StartDate := DMY2DATE(1, 1, Date2DMY(WorkDate(), 3));   // Jan 1 current year
//         EndDate := DMY2DATE(31, 12, Date2DMY(WorkDate(), 3));  // Dec 31 current year
//     end;
 
//     local procedure GetCMRange(var StartDate: Date; var EndDate: Date)
//     var
//         m: Integer;
//         y: Integer;
//     begin
//         m := Date2DMY(WorkDate(), 2);
//         y := Date2DMY(WorkDate(), 3);
//         StartDate := DMY2DATE(1, m, y);
//         EndDate := CalcDate('<CM>', WorkDate()); // end of current month
//     end;
 
//     local procedure GetCQRange(var StartDate: Date; var EndDate: Date)
//     var
//         q: Integer;
//         y: Integer;
//     begin
//         y := Date2DMY(WorkDate(), 3);
//         q := (Date2DMY(WorkDate(), 2) - 1) DIV 3 + 1; // Quarter number (1–4)
 
//         case q of
//             1:
//                 begin
//                     StartDate := DMY2DATE(1, 1, y);
//                     EndDate := DMY2DATE(31, 3, y);
//                 end;
//             2:
//                 begin
//                     StartDate := DMY2DATE(1, 4, y);
//                     EndDate := DMY2DATE(30, 6, y);
//                 end;
//             3:
//                 begin
//                     StartDate := DMY2DATE(1, 7, y);
//                     EndDate := DMY2DATE(30, 9, y);
//                 end;
//             4:
//                 begin
//                     StartDate := DMY2DATE(1, 10, y);
//                     EndDate := DMY2DATE(31, 12, y);
//                 end;
//         end;
//     end;
 
//     local procedure GetHalfYearRange(var StartDate: Date; var EndDate: Date)
//     var
//         m: Integer;
//         y: Integer;
//     begin
//         m := Date2DMY(WorkDate(), 2);
//         y := Date2DMY(WorkDate(), 3);
 
//         if m <= 6 then begin
//             StartDate := DMY2DATE(1, 1, y);
//             EndDate := DMY2DATE(30, 6, y);
//         end else begin
//             StartDate := DMY2DATE(1, 7, y);
//             EndDate := DMY2DATE(31, 12, y);
//         end;
//     end;
 
//     local procedure GetCurrentYearBudget(Category: Code[100]): Decimal
//     var
//         ExpenseBudget: Record Budget;
//         StartD: Date;
//         EndD: Date;
//         TotalBudget: Decimal;
//     begin
//         GetCYRange(StartD, EndD);
//         ExpenseBudget.SetRange(CategoryName, Category);
//         ExpenseBudget.SetRange(FromDate, StartD, EndD);
 
//         if ExpenseBudget.FindSet() then
//             repeat
//                 TotalBudget += ExpenseBudget.Amount;
//             until ExpenseBudget.Next() = 0;
 
//         exit(TotalBudget);
//     end;
// }
 
 