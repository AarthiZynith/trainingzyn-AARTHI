page 50151 "Budget Totals FactBox"
{
    PageType = CardPart;
    SourceTable = ExpenseCategory; // assuming you show per Category
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            cuegroup(Budgets)
            {
                field("Current Month Total"; CurrentMonthTotal)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        BudgetRec: Record Budget;
                    begin
                        BudgetRec.Reset();
                        BudgetRec.SetRange(CategoryName, Rec.Name);
                        BudgetRec.SetRange(FromDate, CalcDate('<CM-1M+1D>', WorkDate), CalcDate('<CM>', WorkDate));
                        Page.Run(Page::BudgetList, BudgetRec);
                    end;
                }

                field("Current Quarter Total"; CurrentQuarterTotal)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        BudgetRec: Record Budget;
                    begin
                        BudgetRec.Reset();
                        BudgetRec.SetRange(CategoryName, Rec.Name);
                        BudgetRec.SetRange(FromDate, CalcDate('<-CQ>', WorkDate), CalcDate('<CQ>', WorkDate));
                        Page.Run(Page::BudgetList, BudgetRec);
                    end;
                }

                field("Current Half-Year Total"; CurrentHalfYearTotal)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        BudgetRec: Record Budget;
                    begin
                        BudgetRec.Reset();
                        BudgetRec.SetRange(CategoryName, Rec.Name);
                        BudgetRec.SetRange(FromDate, CalcDate('-6M', WorkDate), WorkDate);
                        Page.Run(Page::BudgetList, BudgetRec);
                    end;
                }

                field("Current Year Total"; CurrentYearTotal)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        BudgetRec: Record Budget;
                    begin
                        BudgetRec.Reset();
                        BudgetRec.SetRange(CategoryName, Rec.Name);
                        BudgetRec.SetRange(FromDate, CalcDate('<CY-1Y+1D>', WorkDate), CalcDate('<CY>', WorkDate));
                        Page.Run(Page::BudgetList, BudgetRec);
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
        BudgetRec: Record Budget;
        StartD: Date;
        EndD: Date;

        BudgetBudget: Record Budget;
        TotalBudget: Decimal;
        budget: Record Budget;
    begin
        // Current Month
        BudgetRec.Reset();
        BudgetRec.SetRange(CategoryName, Rec.Name);
        BudgetRec.SetRange(FromDate, CalcDate('<CM-1M+1D>', WorkDate), CalcDate('<CM>', WorkDate));
        BudgetRec.CalcSums(Amount);
        CurrentMonthTotal := BudgetRec.Amount;

        //CurrentMonthTotal := BudgetRec.CalcSums(Amount);


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