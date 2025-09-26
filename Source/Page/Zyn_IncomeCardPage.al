page 50108 Zyn_IncomeCard
{
    Caption='IncomeCard';
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_Income;

    layout
    {
        area(Content)
        {
            group(genereal)
            {
                field(IncomeID; Rec.IncomeID)
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
            }
        }
    }
}