page 50108 IncomeCardPage
{
    PageType = Card;
    ApplicationArea = All;
    //UsageCategory = Lists;
    SourceTable = Income;

    layout
    {
        area(Content)
        {
            group(genereal){
            field(IncomeID; Rec.IncomeID) { ApplicationArea = All; }
            field(Description; Rec.Description) { ApplicationArea = All; }
            field(Amount; Rec.Amount) { ApplicationArea = All; }
            field(Date; Rec.Date) { ApplicationArea = All; }

            field(CategoryName;Rec.CategoryName)
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
}