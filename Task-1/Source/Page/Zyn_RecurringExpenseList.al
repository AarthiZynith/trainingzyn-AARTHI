page 50154 RecurringExpenseList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable =RecurringExpenses;
    CardPageId = RecurringExpenseCard;
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(EntryNo;Rec.EntryNo)
                {
                   ApplicationArea=All; 
                }
                field(Category;Rec.Category){ApplicationArea=All;}
                field(Amount;Rec.Amount){ApplicationArea=All;}
                field(Cycle;Rec.Cycle){ApplicationArea=All;}
                field(NextCycleDate;Rec.NextCycleDate){ApplicationArea=All;}
                Field(StartDate;Rec.StartDate){ApplicationArea=All;}
            }
        }
    }
    
    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {
                
    //             trigger OnAction()
    //             begin
                    
    //             end;
    //         }
    //     }
    // }
    
    
}