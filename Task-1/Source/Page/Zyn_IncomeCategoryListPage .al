page 50136 IncomeCategoryListPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = IncomeCategory;
    CardPageId = IncomeCategoryPage;
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
            part("Income Totals"; "Income Totals FactBox")
            {
                ApplicationArea = All;
                SubPageLink = Name = field(Name); // Link CardPart to selected category
            }
        }



    }
}