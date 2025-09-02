page 50106 ExpenseCategoryPage
{
    PageType = Card;
    ApplicationArea = All;
   // UsageCategory = Lists;
    SourceTable = ExpenseCategory;
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                // field(CategoryNo;Rec.CategoryNo)
                // {
                //     ApplicationArea=All;
                //   //  LookupPageId = "Expense Category Lookup";
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