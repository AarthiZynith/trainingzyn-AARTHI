page 50154 Zyn_RecurringExpense
{
    Caption='RecurringExpenseList';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_RecurringExpenses;
    CardPageId = Zyn_RecurringExpenseCard;

    layout
    {
        area(Content)
        {
            repeater(Group)
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