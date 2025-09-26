page 50231 Zyn_ExpenseClaimCategoryList
{
    PageType = list;
    Caption='ExpenseClaimCategoryList';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Zyn_ExpenseClaimCategory;
    Editable = false;
    ModifyAllowed = false;
    CardPageId = Zyn_ExpenseClaimCategoryCard;

    layout
    {
        area(Content)
        {
            repeater(General)
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