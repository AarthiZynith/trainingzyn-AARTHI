page 50136 Zyn_IncomeCategoryList
{
    Caption = 'IncomeCategoryList';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_IncomeCategory;
    CardPageId = Zyn_IncomeCategoryCard;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {

                }
                field(Description; Rec.Description)
                {

                }
            }

        }

        area(FactBoxes)
        {
            part("Income Totals"; Zyn_IncomeTotalsFactBox)
            {
                ApplicationArea = All;
                SubPageLink = Name = field(Name); // Link CardPart to selected category
            }
        }

    }
}