page 50105 Zyn_ExpenseList
{
    Caption = 'ExpenseList';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Zyn_Expense;
    CardPageId = Zyn_ExpenseCard;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(genereal)
            {
                field(ExpenseID; Rec.ExpenseID)
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("Remaining Budget"; rec."Remaining Budget")
                {

                }
                field(Amount; Rec.Amount)
                {

                }
                field(Date; Rec.Date)
                {

                }

                field(CategoryName; Rec.CategoryName)
                {

                }
            }
        }

        area(FactBoxes)
        {
            part("Budget"; Zyn_BudgetFactBox)
            {
                ApplicationArea = All;

            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(categories)
            {
                RunObject = page Zyn_ExpenseCategoryList;
            }
            action(ExpenseExport)
            {
                RunObject = report Zyn_ExpenseExportReport;

            }
        }
    }
}