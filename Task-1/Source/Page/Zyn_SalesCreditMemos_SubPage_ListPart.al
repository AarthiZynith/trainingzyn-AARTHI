page 50118 "Sales Credit Memos Subpage"
{
    PageType = ListPart;
    SourceTable = "Sales Header";
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    SourceTableView = WHERE("Document Type" = CONST("Credit Memo"));
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {

                    ApplicationArea = all;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        SalesOrderPage: Page "Sales Credit Memo";
                    begin
                        SalesOrderPage.SetRecord(Rec); // 🔄 Pass current Sales Header record
                        SalesOrderPage.Run();     // 📋 Opens the specific order
                    end;
                }
                field("Credit Date"; rec."Document Date") { }
                field(Amount; rec.Amount) { }
            }
        }
    }

    // SourceTableView = WHERE("Document Type" = CONST("Credit Memo"));
}
