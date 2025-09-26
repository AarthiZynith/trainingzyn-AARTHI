page 50142 Zyn_BudgetFactBox
{
    Caption = 'BudgetFactBox';
    PageType = ListPart;
    SourceTable = Zyn_Budget;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("From Date"; Rec."FromDate")
                {

                }
                field("To Date"; rec."ToDate")
                {

                }
                field("CategoryName"; rec.CategoryName)
                {

                }
                field("Budget Amount"; rec.Amount)
                {

                }
            }
        }
    }
    trigger OnOpenPage()
    var
        start: Date;
        endin: Date;
    begin
        start := CalcDate('<-CM>', WorkDate());
        endin := CalcDate('<CD>', WorkDate());
        Rec.SetRange(FromDate, start, endin);
    end;
}
