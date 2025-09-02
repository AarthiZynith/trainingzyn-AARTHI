page 50107 IncomeListPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Income;
    CardPageId = IncomeCardPage;

    layout
    {
        area(Content)
        {
            repeater(genereal)
            {
                field(IncomeID; Rec.IncomeID) { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
                field(Date; Rec.Date) { ApplicationArea = All; }

                field(CategoryName; Rec.CategoryName)
                {
                    ApplicationArea = All;
                    Caption = 'Category';
                    // LookupPageId = "Income Category Lookup";

                    // trigger OnLookup(var Text: Text): Boolean
                    // var
                    //     Cat: Record IncomeCategory;
                    // begin
                    //     if Page.RunModal(Page::"Income Category Lookup", Cat) = Action::LookupOK then begin
                    //         Rec.CategoryNo := Cat.CategoryNo; // store No
                    //         Rec.Modify(); // save it
                    //     end;
                    //     exit(true);
                    // end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(categories)
            {
                RunObject = page IncomeCategoryListPage;
            }
            action(IncomeExport)
            {
                RunObject = report "Income Export Report";

            }
        }
    }
}