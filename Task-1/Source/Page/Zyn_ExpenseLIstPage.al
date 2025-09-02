page 50105 ExpenseListPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Expense;
    CardPageId = ExpenseCardPage;
    Editable=false;

    layout
    {
        area(Content)
        {
            repeater(genereal)
            {
                field(ExpenseID; Rec.ExpenseID) { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field("Remaining Budget"; rec."Remaining Budget") { }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
                field(Date; Rec.Date) { ApplicationArea = All; }

                field(CategoryName; Rec.CategoryName)
                {
                    ApplicationArea = All;
                    Caption = 'Category';
                    // LookupPageId = "Expense Category Lookup";

                    // trigger OnLookup(var Text: Text): Boolean
                    // var
                    //     Cat: Record ExpenseCategory;
                    // begin
                    //     if Page.RunModal(Page::"Expense Category Lookup", Cat) = Action::LookupOK then begin
                    //         Rec.CategoryNo := Cat.CategoryNo; // store No
                    //         Rec.Modify(); // save it
                    //     end;
                    //     exit(true);
                    // end;
                }
            }
        }

        area(FactBoxes)
        {
            part("Budget"; "Budget FactBox")
            {
                ApplicationArea = All;
                //SubPageLink =CategoryName=field(CategoryName);// Link CardPart to selected category
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(categories)
            {
                RunObject = page ExpenseCategoryListPage;
            }
            action(ExpenseExport)
            {
                RunObject = report "Expense Export Report";

            }
        }
    }



}