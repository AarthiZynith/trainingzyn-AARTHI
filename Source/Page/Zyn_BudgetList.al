
page 50135 Zyn_BudgetList
{
    Caption = 'BudgetList';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_Budget;
    ModifyAllowed = false;
    InsertAllowed = false;
    CardPageId = Zyn_BudgetCard;
    layout
    {
        area(content)
        {
            repeater(group)
            {
                field(BudgetID; Rec.BudgetID)
                {

                }
                field(FromDate; Rec.FromDate)
                {

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
}