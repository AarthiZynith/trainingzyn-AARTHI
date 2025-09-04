page 50125 IncomeCategoryPage
{
    PageType = Card;
    ApplicationArea = All;
   // UsageCategory = Lists;
    SourceTable = IncomeCategory;
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                // field(CategoryNo;Rec.CategoryNo)
                // {
                //     ApplicationArea=All;
                //   //  LookupPageId = "Income Category Lookup";
                // }
                field(CategoryName;Rec.Name)
                {
                    ApplicationArea=All;
                    
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea=All;
                }
            }
        }
    }
    
}