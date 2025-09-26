
page 50126 Zyn_BudgetCard
{
    Caption='BudgetCard';
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_budget;
    
    layout
    {
        area(content)
        {
            group(general)
            {
                field(BudgetID; Rec.BudgetID)
                {
                    
                }
                field(FromDate; Rec.FromDate)
                {
                    Editable=false;
                }
                field(ToDate; Rec.ToDate)
                {
                   
                }
                field(CategoryName; Rec.CategoryName)
                {
                   
                }
                field(Amount; Rec.Amount)
                {
                   
                }

            }
        }

    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetDefaultDates();
    end;

    trigger OnAfterGetRecord()
    begin
        if (Rec.FromDate = 0D) or (Rec.ToDate = 0D) then
            SetDefaultDates();
    end;

    local procedure SetDefaultDates()
    var
        FirstDate: Date;
        LastDate: Date;
    begin
        FirstDate := CalcDate('<-CM>', WorkDate); // first day of current month
        LastDate := CalcDate('<CM>', WorkDate);   // last day of current month

        Rec.FromDate := FirstDate;
        Rec.ToDate := LastDate;
    end;
}