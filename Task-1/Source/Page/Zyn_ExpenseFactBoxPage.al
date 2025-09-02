page 50119 "Expense Totals FactBox"
{
    PageType = CardPart;
    SourceTable = ExpenseCategory; // assuming you show per Category
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            cuegroup(Expenses)
            {
                field("Current Month Total"; CurrentMonthTotal)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        ExpenseRec: Record Expense;
                    begin
                        ExpenseRec.Reset();
                        ExpenseRec.SetRange(CategoryName, Rec.Name);
                        Rec.SetRange(Date, CalcDate('<CM-1M+1D>', WorkDate), CalcDate('<CM>', WorkDate));
                        Page.Run(Page::ExpenseListPage, ExpenseRec);
                    end;
                }

                field("Current Quarter Total"; CurrentQuarterTotal)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        ExpenseRec: Record Expense;
                    begin
                        ExpenseRec.Reset();
                        ExpenseRec.SetRange(CategoryName, Rec.Name);
                        Rec.SetRange(Date, CalcDate('<CQ-1Q+1D>', WorkDate), CalcDate('<CQ>', WorkDate));
                        Page.Run(Page::ExpenseListPage, ExpenseRec);
                    end;
                }

                field("Current Half-Year Total"; CurrentHalfYearTotal)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        ExpenseRec: Record Expense;
                    begin
                        ExpenseRec.Reset();
                        ExpenseRec.SetRange(CategoryName, Rec.Name);
                        Rec.SetRange("Date", CalcDate('-6M', WorkDate), WorkDate);
                        Page.Run(Page::ExpenseListPage, ExpenseRec);
                    end;
                }

                field("Current Year Total"; CurrentYearTotal)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        ExpenseRec: Record Expense;
                    begin
                        ExpenseRec.Reset();
                        ExpenseRec.SetRange(CategoryName, Rec.Name);
                        Rec.SetRange("Date", CalcDate('<CY-1Y+1D>', WorkDate), CalcDate('<CY>', WorkDate));
                        Page.Run(Page::ExpenseListPage, ExpenseRec);
                    end;
                }


            }

            group(RemainingBudget)
            {
                field("Remaining Budget"; Rec.RemBudget)
                {
                    ApplicationArea = All;

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
        ExpenseRec: Record Expense;
        StartD: Date;
        EndD: Date;

        ExpenseBudget: Record Expense;
        TotalBudget: Decimal;
        budget: Record Budget;
    begin
        // Current Month
        ExpenseRec.Reset();
        ExpenseRec.SetRange(CategoryName, Rec.Name);
        ExpenseRec.SetRange("Date", CalcDate('<CM-1M+1D>', WorkDate), CalcDate('<CM>', WorkDate));
        ExpenseRec.CalcSums(Amount);
        CurrentMonthTotal := ExpenseRec.Amount;

        //CurrentMonthTotal := ExpenseRec.CalcSums(Amount);


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
        // GetCurrentYearBudget();

        // // Remaining Budget = Yearly Budget – Yearly Expenses
        // GetCYRange(StartD, EndD);
        // ExpenseCurrentYearBudget := GetCurrentYearBudget(Rec.Name, StartD, EndD);
        // RemainingBudget := ExpenseCurrentYearBudget - CurrentYearTotal;

    end;

    //     local procedure CalcRemainingBudget()
    // var
    //     Bud: Record "Budget";
    //     Exp: Record "Expense";
    //     StartDate: Date;
    //     EndDate: Date;
    // begin
    //     Clear(RemainingBudget);

    //     // Get current work month range
    //     StartDate := CalcDate('<CM-1M+1D>', WorkDate); // first day of current month
    //     EndDate := CalcDate('<CM>', WorkDate);         // last day of current month

    //     // Find budget for this category where the workdate falls in range
    //     Bud.Reset();
    //     Bud.SetRange(CategoryName, Rec.Name);
    //     Bud.SetFilter(FromDate, '<=%1', EndDate);
    //     Bud.SetFilter(ToDate, '>=%1', StartDate);
    //     if Bud.FindFirst() then begin
    //         // Sum all expenses for this category in the same date range
    //         Exp.Reset();
    //         Exp.SetRange(CategoryName, Rec.Name);
    //         Exp.SetRange("Date", StartDate, EndDate);
    //         Exp.CalcSums(Amount);

    //         RemainingBudget := Bud.Amount - Exp.Amount;
    //     end;
    // end;



    local procedure GetCurrentYearBudget(Category: Code[100]; StartD: Date; EndD: Date): Decimal
    var
        ExpenseBudget: Record Expense;
        TotalBudget: Decimal;
        budget: Record Budget;
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
