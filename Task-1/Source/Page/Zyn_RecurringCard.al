page 50155 RecurringExpenseCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = RecurringExpenses;
    

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(EntryNo; Rec.EntryNo)
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category) { ApplicationArea = All; }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
                field(Cycle; Rec.Cycle) { ApplicationArea = All; }
                field(NextCycleDate; Rec.NextCycleDate) { ApplicationArea = All; }
                Field(StartDate; Rec.StartDate) { ApplicationArea = All; }
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