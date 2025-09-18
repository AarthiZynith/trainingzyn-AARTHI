page 50231 Zyn_ExpenseClaimCategoryList
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Zyn_ExpenseClaimCategory;
    Editable=false;
    ModifyAllowed=false;
    CardPageId=Zyn_ExpenseClaimCategoryCard;
    
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ClaimCode;Rec.ClaimCode)
                {
                    ApplicationArea=All;
                }
                field(CategoryName;Rec.CategoryName){ApplicationArea=All;}
                field(SubType;Rec.SubType){ApplicationArea=All;}
                field(Description;Rec.Description){ApplicationArea=All;}
                field(CategoryLimit;Rec.CategoryLimit){ApplicationArea=All;}
            }
        }
    }
}