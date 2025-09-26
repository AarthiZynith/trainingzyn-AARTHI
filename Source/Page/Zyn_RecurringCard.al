page 50155 Zyn_RecurringExpenseCard
{
    Caption = 'RecurringExpenseCard';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_RecurringExpenses;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(EntryNo; Rec.EntryNo)
                {

                }
                field(Category; Rec.Category)
                {

                }
                field(Amount; Rec.Amount)
                {

                }
                field(Cycle; Rec.Cycle)
                {

                }
                field(NextCycleDate; Rec.NextCycleDate)
                {

                }
                Field(StartDate; Rec.StartDate)
                {

                }
            }
        }
    }

}