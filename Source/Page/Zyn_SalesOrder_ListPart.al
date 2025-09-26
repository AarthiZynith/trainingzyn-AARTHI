page 50110 Zyn_SalesOrderSubpage
{
    Caption = 'SalesOrderSubpage';
    PageType = ListPart;
    SourceTable = "Sales Header";
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = WHERE("Document Type" = CONST(Order));
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        SalesOrderPage: Page "Sales Order";
                    begin
                        SalesOrderPage.SetRecord(Rec); // 🔄 Pass current Sales Header record
                        SalesOrderPage.Run();     // 📋 Opens the specific order
                    end;

                }
                field("Order Date"; rec."Order Date")
                {

                }
                field(Amount; rec.Amount)
                {

                }
            }
        }
    }
}
