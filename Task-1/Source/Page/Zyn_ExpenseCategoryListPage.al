page 50114 ExpenseCategoryListPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ExpenseCategory;
    CardPageId = ExpenseCategoryPage;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name) { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
            }



        }


        area(FactBoxes)
        {
            part("Expense Totals"; "Expense Totals FactBox")
            {
                ApplicationArea = All;
                SubPageLink = Name = field(Name); // Link CardPart to selected category
            }

             part("Budget Totals"; "Budget Totals FactBox")
            {
                ApplicationArea = All;
                SubPageLink = Name = field(Name); // Link CardPart to selected category
            }
        }

       



    }
}