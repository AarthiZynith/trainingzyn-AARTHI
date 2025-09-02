page 50134 ExpenseCardPage
{
    PageType = Card;
    ApplicationArea = All;
    //UsageCategory = Lists;
    SourceTable = Expense;

    layout
    {
        area(Content)
        {
            group(genereal){
            field(ExpenseID; Rec.ExpenseID) { ApplicationArea = All; }
            field(Description; Rec.Description) { ApplicationArea = All; }
            field(Amount; Rec.Amount) { ApplicationArea = All; }
            field(Date; Rec.Date) { ApplicationArea = All; }

            field(CategoryName;Rec.CategoryName)
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
            field("Remaining Budget";Rec."Remaining Budget"){
                ApplicationArea=All;
            }
        }
    }
}
}