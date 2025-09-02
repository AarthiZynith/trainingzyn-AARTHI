page 50113 "Sales Invoices Subpage"
{
    PageType = ListPart;
    SourceTable = "Sales Header";
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = WHERE("Document Type" = CONST(Invoice));
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
                        SalesOrderPage: Page "Sales Invoice";
                    begin
                        SalesOrderPage.SetRecord(Rec); // 🔄 Pass current Sales Header record
                        SalesOrderPage.Run();     // 📋 Opens the specific order
                    end;
                }
                field("Invoice Date"; rec."Document Date") { }
                field(Amount; rec.Amount) { }
            }
        }    //SourceTableView = WHERE("Document Type" = CONST(Invoice));
    }

}

