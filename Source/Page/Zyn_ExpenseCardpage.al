page 50134 Zyn_ExpenseCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_Expense;
    Caption='ExpenseCard';
    layout
    {
        area(Content)
        {
            group(genereal)
            {
                field(ExpenseID; Rec.ExpenseID)
                {

                }
                field(Description; Rec.Description)
                {
                    
                }
                field(Amount; Rec.Amount)
                {
                    
                }
                field(Date; Rec.Date)
                {
                    
                }

                field(CategoryName; Rec.CategoryName)
                {    

                }
                field("Remaining Budget"; Rec."Remaining Budget")
                {
                    
                }
            }
        }
    }
}