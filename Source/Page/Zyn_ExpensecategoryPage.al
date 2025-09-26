page 50106 Zyn_ExpenseCategoryCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_ExpenseCategory;
    Caption = 'ExpenseCategoryard';
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