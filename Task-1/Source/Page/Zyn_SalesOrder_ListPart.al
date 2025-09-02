page 50110 "Sales Orders Subpage"
{
    PageType = ListPart;
    SourceTable = "Sales Header";
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    SourceTableView = WHERE("Document Type" = CONST(Order));
    //CardPageId = "Sales Order";

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
                        SalesOrderPage: Page "Sales Order";
                    begin
                        SalesOrderPage.SetRecord(Rec); // 🔄 Pass current Sales Header record
                        SalesOrderPage.Run();     // 📋 Opens the specific order
                    end;

                }
                field("Order Date"; rec."Order Date") { }
                field(Amount; rec.Amount) { }
            }
        }
    }

    //     trigger OnAfterGetRecord()
    //     begin
    //         // optional logic
    //     end;

    //     // Filter by Sell-to Customer No. and Document Type = Order
    //     SourceTableView = WHERE("Document Type" = CONST(Order));
    // 
}
