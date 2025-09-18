page 50236 Zyn_ExpenseClaimCategoryCard
{
    PageType = Card;
    ApplicationArea = All;
   //sageCategory = Administration;
    SourceTable = Zyn_ExpenseClaimCategory;
    
    
    layout
    {
        area(Content)
        {
            group(general)
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