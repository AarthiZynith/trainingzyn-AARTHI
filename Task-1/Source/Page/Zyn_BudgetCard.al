
page 50126 BudgetCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = budget;
    layout
    {
        area(content)
        {
            group(general)
            {
                field(BudgetID; Rec.BudgetID)
                {
                    ApplicationArea = All;
                }
                field(FromDate; Rec.FromDate)
                {
                    ApplicationArea = All;
                    Editable=false;
                }
                field(ToDate; Rec.ToDate)
                {
                    ApplicationArea = All;
                    
                }
                field(CategoryName; Rec.CategoryName)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
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