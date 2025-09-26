page 50116 Zyn_IncomeTotalsFactBox
{
    Caption='IncomeTotalsFactBox';
    PageType = CardPart;
    SourceTable = Zyn_IncomeCategory; 
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            cuegroup(Incomes)
            {
                field("Current Month Total"; CurrentMonthTotal)
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        IncomeRec: Record Zyn_Income;
                    begin
                        IncomeRec.Reset();
                        IncomeRec.SetRange(CategoryName, Rec.Name);
                        Rec.SetRange(Date, CalcDate('<CM-1M+1D>', WorkDate), CalcDate('<CM>', WorkDate));
                        Page.Run(Page::Zyn_IncomeList, IncomeRec);
                    end;
                }

                field("Current Quarter Total"; CurrentQuarterTotal)
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        IncomeRec: Record Zyn_Income;
                    begin
                        IncomeRec.Reset();
                        IncomeRec.SetRange(CategoryName, Rec.Name);
                        Rec.SetRange(Date, CalcDate('<CQ-1Q+1D>', WorkDate), CalcDate('<CQ>', WorkDate));
                        Page.Run(Page::Zyn_IncomeList, IncomeRec);
                    end;
                }
                field("Current Half-Year Total"; CurrentHalfYearTotal)
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        IncomeRec: Record Zyn_Income;
                    begin
                        IncomeRec.Reset();
                        IncomeRec.SetRange(CategoryName, Rec.Name);
                        Rec.SetRange("Date", CalcDate('-6M', WorkDate), WorkDate);
                        Page.Run(Page::Zyn_IncomeList, IncomeRec);
                    end;
                }
                field("Current Year Total"; CurrentYearTotal)
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        IncomeRec: Record Zyn_Income;
                    begin
                        IncomeRec.Reset();
                        IncomeRec.SetRange(CategoryName, Rec.Name);
                        Rec.SetRange("Date", CalcDate('<CY-1Y+1D>', WorkDate), CalcDate('<CY>', WorkDate));
                        Page.Run(Page::Zyn_IncomeList, IncomeRec);
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
        IncomeRec: Record Zyn_Income;
    begin
        // Current Month
        IncomeRec.Reset();
        IncomeRec.SetRange(CategoryName, Rec.Name);
        IncomeRec.SetRange("Date", CalcDate('<CM-1M+1D>', WorkDate), CalcDate('<CM>', WorkDate));
        IncomeRec.CalcSums(Amount);
        CurrentMonthTotal := IncomeRec.Amount;

        // Current Quarter
        IncomeRec.Reset();
        IncomeRec.SetRange(CategoryName, Rec.Name);
        IncomeRec.SetRange("Date", CalcDate('<CQ-1Q+1D>', WorkDate), CalcDate('<CQ>', WorkDate));
        IncomeRec.CalcSums(Amount);
        CurrentQuarterTotal := IncomeRec.Amount;

        // Current Half-Year
        IncomeRec.Reset();
        IncomeRec.SetRange(CategoryName, Rec.Name);
        IncomeRec.SetRange("Date", CalcDate('-6M', WorkDate), WorkDate);
        IncomeRec.CalcSums(Amount);
        CurrentHalfYearTotal := IncomeRec.Amount;
        // Current Year
        IncomeRec.Reset();
        IncomeRec.SetRange(CategoryName, Rec.Name);
        IncomeRec.SetRange("Date", CalcDate('<CY-1Y+1D>', WorkDate), CalcDate('<CY>', WorkDate));
        IncomeRec.CalcSums(Amount);
        CurrentYearTotal := IncomeRec.Amount;
    end;
}
