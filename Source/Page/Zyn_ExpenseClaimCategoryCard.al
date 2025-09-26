page 50236 Zyn_ExpenseClaimCategoryCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_ExpenseClaimCategory;
    Caption = 'ExpenseClaimCategoryCard';
    layout
    {
        area(Content)
        {
            group(general)
            {
                field(ClaimCode; Rec.ClaimCode)
                {

                }
                field(CategoryName; Rec.CategoryName)
                {

                }
                field(SubType; Rec.SubType)
                {

                }
                field(Description; Rec.Description)
                {

                }
                field(CategoryLimit; Rec.CategoryLimit)
                {

                }
            }
        }
    }
}