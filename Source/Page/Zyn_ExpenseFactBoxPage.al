page 50119 Zyn_ExpenseTotalsFactBox
{
    PageType = CardPart;
    Caption = 'expenseTotalsFactBox';
    SourceTable = Zyn_ExpenseCategory;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            cuegroup(Expenses)
            {
                field("Current Month Total"; CurrentMonthTotal)
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        ExpenseRec: Record Zyn_Expense;
                    begin
                        ExpenseRec.Reset();
                        ExpenseRec.SetRange(CategoryName, Rec.Name);
                        Rec.SetRange(Date, CalcDate('<CM-1M+1D>', WorkDate), CalcDate('<CM>', WorkDate));
                        Page.Run(Page::Zyn_ExpenseList, ExpenseRec);
                    end;
                }

                field("Current Quarter Total"; CurrentQuarterTotal)
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        ExpenseRec: Record Zyn_Expense;
                    begin
                        ExpenseRec.Reset();
                        ExpenseRec.SetRange(CategoryName, Rec.Name);
                        Rec.SetRange(Date, CalcDate('<CQ-1Q+1D>', WorkDate), CalcDate('<CQ>', WorkDate));
                        Page.Run(Page::Zyn_ExpenseList, ExpenseRec);
                    end;
                }

                field("Current Half-Year Total"; CurrentHalfYearTotal)
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        ExpenseRec: Record Zyn_Expense;
                    begin
                        ExpenseRec.Reset();
                        ExpenseRec.SetRange(CategoryName, Rec.Name);
                        Rec.SetRange("Date", CalcDate('-6M', WorkDate), WorkDate);
                        Page.Run(Page::Zyn_ExpenseList, ExpenseRec);
                    end;
                }

                field("Current Year Total"; CurrentYearTotal)
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        ExpenseRec: Record Zyn_Expense;
                    begin
                        ExpenseRec.Reset();
                        ExpenseRec.SetRange(CategoryName, Rec.Name);
                        Rec.SetRange("Date", CalcDate('<CY-1Y+1D>', WorkDate), CalcDate('<CY>', WorkDate));
                        Page.Run(Page::Zyn_ExpenseList, ExpenseRec);
                    end;
                }

            }

            group(RemainingBudget)
            {
                field("Remaining Budget"; Rec.RemBudget)
                {

                }
            }
        }
    }

    var
        CurrentMonthTotal: Decimal;
        CurrentQuarterTotal: Decimal;
        CurrentHalfYearTotal: Decimal;
        CurrentYearTotal: Decimal;
        RemainingBudget: Decimal;
        ExpenseCurrentYearBudget: Decimal;


    trigger OnAfterGetRecord()
    var
        ExpenseRec: Record Zyn_Expense;
        StartD: Date;
        EndD: Date;

        ExpenseBudget: Record Zyn_Expense;
        TotalBudget: Decimal;
        budget: Record Zyn_Budget;
    begin
        // Current Month
        ExpenseRec.Reset();
        ExpenseRec.SetRange(CategoryName, Rec.Name);
        ExpenseRec.SetRange("Date", CalcDate('<CM-1M+1D>', WorkDate), CalcDate('<CM>', WorkDate));
        ExpenseRec.CalcSums(Amount);
        CurrentMonthTotal := ExpenseRec.Amount;

        // Current Quarter
        ExpenseRec.Reset();
        ExpenseRec.SetRange(CategoryName, Rec.Name);
        ExpenseRec.SetRange("Date", CalcDate('<CQ-1Q+1D>', WorkDate), CalcDate('<CQ>', WorkDate));
        ExpenseRec.CalcSums(Amount);
        CurrentQuarterTotal := ExpenseRec.Amount;

        // Current Half-Year
        ExpenseRec.Reset();
        ExpenseRec.SetRange(CategoryName, Rec.Name);
        ExpenseRec.SetRange("Date", CalcDate('-6M', WorkDate), WorkDate);
        ExpenseRec.CalcSums(Amount);
        CurrentHalfYearTotal := ExpenseRec.Amount;
        // Current Year
        ExpenseRec.Reset();
        ExpenseRec.SetRange(CategoryName, Rec.Name);
        ExpenseRec.SetRange("Date", CalcDate('<CY-1Y+1D>', WorkDate), CalcDate('<CY>', WorkDate));
        ExpenseRec.CalcSums(Amount);
        CurrentYearTotal := ExpenseRec.Amount;
        //Remaining Budget
        StartD := CalcDate('<-CM>', WorkDate); // 1st day of current year
        EndD := CalcDate('<CM>', WorkDate);         // last day of current year
        ExpenseBudget.Reset();
        ExpenseBudget.SetRange(CategoryName, rec.Name);
        ExpenseBudget.SetRange(Date, StartD, EndD);

        if ExpenseBudget.FindSet() then
            repeat
                TotalBudget += ExpenseBudget.Amount;
            until ExpenseBudget.Next() = 0;
        budget.Reset();
        budget.SetRange(FromDate, StartD);
        budget.SetRange(ToDate, EndD);
        budget.SetRange(CategoryName, Rec.Name);
        if budget.FindFirst() then
            Rec.RemBudget := budget.Amount - TotalBudget
        else
            RemainingBudget -= TotalBudget;

    end;

    local procedure GetCurrentYearBudget(Category: Code[100]; StartD: Date; EndD: Date): Decimal
    var
        ExpenseBudget: Record Zyn_Expense;
        TotalBudget: Decimal;
        budget: Record Zyn_Budget;
    begin
        StartD := CalcDate('<-CM>', WorkDate); // 1st day of current year
        EndD := CalcDate('<CM>', WorkDate);         // last day of current year
        ExpenseBudget.Reset();
        ExpenseBudget.SetRange(CategoryName, Category);
        ExpenseBudget.SetRange(Date, StartD, EndD);

        if ExpenseBudget.FindSet() then
            repeat
                TotalBudget += ExpenseBudget.Amount;
            until ExpenseBudget.Next() = 0;
        budget.Reset();
        budget.SetRange(FromDate, StartD);
        budget.SetRange(ToDate, EndD);
        budget.SetRange(CategoryName, Rec.Name);
        if budget.FindFirst() then
            Rec.RemBudget := budget.Amount - TotalBudget
        else
            RemainingBudget -= TotalBudget;

        //exit(TotalBudget);
    end;

    local procedure GetCYRange(var StartD: Date; var EndD: Date)
    begin
        StartD := CalcDate('<CY-1Y+1D>', WorkDate); // 1st day of current year
        EndD := CalcDate('<CY>', WorkDate);         // last day of current year
    end;

}
