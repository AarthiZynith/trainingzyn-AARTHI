page 50109 "My Customer List"
{
    PageType = List;
    SourceTable = "Customer";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'My Customer List';
    Editable=false;
     InsertAllowed=false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.") { }
                field(Name; rec.Name) { }
                field(Address; rec.Address) { }
                field("Post Code"; rec."Post Code") { }
                field(City; rec.City) { }
                field("Phone No."; rec."Phone No.") { }
            }

            
            
                part(SalesOrdersPart; "Sales Orders Subpage")
                {
                    SubPageLink = "Sell-to Customer No." = field("No.");
                ApplicationArea=All;
                }

                part(SalesInvoicesPart; "Sales Invoices Subpage")
                {
                    SubPageLink = "Sell-to Customer No." = field("No.");
                    ApplicationArea=All;
                }

                part(SalesCreditMemosPart; "Sales Credit Memos Subpage")
                {
                    SubPageLink = "Sell-to Customer No." = field("No.");
                    ApplicationArea=All;
                }
            }
        }
    
}
