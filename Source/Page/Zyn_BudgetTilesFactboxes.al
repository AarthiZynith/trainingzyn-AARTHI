page 50151 Zyn_BudgetTotalsFactBox
{
    Caption = 'BudgetTotalsFactBox';
    PageType = CardPart;
    SourceTable = Zyn_ExpenseCategory;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            cuegroup(Budgets)
            {
                field("Current Month Total"; CurrentMonthTotal)
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        BudgetRec: Record Zyn_Budget;
                    begin
                        BudgetRec.Reset();
                        BudgetRec.SetRange(CategoryName, Rec.Name);
                        BudgetRec.SetRange(FromDate, CalcDate('<CM-1M+1D>', WorkDate), CalcDate('<CM>', WorkDate));
                        Page.Run(Page::Zyn_BudgetList, BudgetRec);
                    end;
                }

                field("Current Quarter Total"; CurrentQuarterTotal)
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        BudgetRec: Record Zyn_Budget;
                    begin
                        BudgetRec.Reset();
                        BudgetRec.SetRange(CategoryName, Rec.Name);
                        BudgetRec.SetRange(FromDate, CalcDate('<-CQ>', WorkDate), CalcDate('<CQ>', WorkDate));
                        Page.Run(Page::Zyn_BudgetList, BudgetRec);
                    end;
                }

                field("Current Half-Year Total"; CurrentHalfYearTotal)
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        BudgetRec: Record Zyn_Budget;
                    begin
                        BudgetRec.Reset();
                        BudgetRec.SetRange(CategoryName, Rec.Name);
                        BudgetRec.SetRange(FromDate, CalcDate('-6M', WorkDate), WorkDate);
                        Page.Run(Page::Zyn_BudgetList, BudgetRec);
                    end;
                }

                field("Current Year Total"; CurrentYearTotal)
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        BudgetRec: Record Zyn_Budget;
                    begin
                        BudgetRec.Reset();
                        BudgetRec.SetRange(CategoryName, Rec.Name);
                        BudgetRec.SetRange(FromDate, CalcDate('<CY-1Y+1D>', WorkDate), CalcDate('<CY>', WorkDate));
                        Page.Run(Page::Zyn_BudgetList, BudgetRec);
                    end;
                }

            }

        }
    }

    var
        CurrentMonthTotal: Decimal;
        CurrentQuarterTotal: Decimal;
        CurrentHalfYearTotal: Decimal;
        CurrentYearTotal: Decimal;


    trigger OnAfterGetRecord()
    var
        BudgetRec: Record Zyn_Budget;
        StartD: Date;
        EndD: Date;

        BudgetBudget: Record Zyn_Budget;
        TotalBudget: Decimal;
        budget: Record Zyn_Budget;
    begin
        // Current Month
        BudgetRec.Reset();
        BudgetRec.SetRange(CategoryName, Rec.Name);
        BudgetRec.SetRange(FromDate, CalcDate('<CM-1M+1D>', WorkDate), CalcDate('<CM>', WorkDate));
        BudgetRec.CalcSums(Amount);
        CurrentMonthTotal := BudgetRec.Amount;

        // Current Quarter
        BudgetRec.Reset();
        BudgetRec.SetRange(CategoryName, Rec.Name);
        BudgetRec.SetRange(FromDate, CalcDate('<CQ-1Q+1D>', WorkDate), CalcDate('<CQ>', WorkDate));
        BudgetRec.CalcSums(Amount);
        CurrentQuarterTotal := BudgetRec.Amount;

        // Current Half-Year
        BudgetRec.Reset();
        BudgetRec.SetRange(CategoryName, Rec.Name);
        BudgetRec.SetRange(FromDate, CalcDate('-6M', WorkDate), WorkDate);
        BudgetRec.CalcSums(Amount);
        CurrentHalfYearTotal := BudgetRec.Amount;
        // Current Year                      
        BudgetRec.Reset();
        BudgetRec.SetRange(CategoryName, Rec.Name);
        BudgetRec.SetRange(ToDate, CalcDate('<CY-1Y+1D>', WorkDate), CalcDate('<CY>', WorkDate));
        BudgetRec.CalcSums(Amount);
        CurrentYearTotal := BudgetRec.Amount;
    end;
}