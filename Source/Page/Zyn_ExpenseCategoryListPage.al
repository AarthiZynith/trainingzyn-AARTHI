page 50114 Zyn_ExpenseCategoryList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_ExpenseCategory;
    CardPageId = Zyn_ExpenseCategoryCard;
    Editable = false;
    Caption = 'ExpenseCategory';
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
            part("Expense Totals"; Zyn_ExpenseTotalsFactBox)
            {
                ApplicationArea = All;
                SubPageLink = Name = field(Name); // Link CardPart to selected category
            }

            part("Budget Totals"; Zyn_BudgetTotalsFactBox)
            {
                ApplicationArea = All;
                SubPageLink = Name = field(Name); // Link CardPart to selected category
            }
        }

    }
}