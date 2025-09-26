page 50125 Zyn_IncomeCategoryCard
{
    Caption = 'IncomeCategory';
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_IncomeCategory;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(CategoryName; Rec.Name)
                {

                }
                field(Description; Rec.Description)
                {

                }
            }
        }
    }

}