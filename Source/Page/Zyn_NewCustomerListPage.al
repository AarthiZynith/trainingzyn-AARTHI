page 50109 Zyn_MyCustomerList
{
    PageType = List;
    SourceTable = "Customer";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'My Customer List';
    Editable = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {

                }
                field(Name; rec.Name)
                {

                }
                field(Address; rec.Address)
                {

                }
                field("Post Code"; rec."Post Code")
                {

                }
                field(City; rec.City)
                {

                }
                field("Phone No."; rec."Phone No.")
                {

                }
            }



            part(SalesOrdersPart; Zyn_SalesOrderSubpage)
            {
                SubPageLink = "Sell-to Customer No." = field("No.");
                ApplicationArea = All;
            }

            part(SalesInvoicesPart; Zyn_SalesInvoicesSubpage)
            {
                SubPageLink = "Sell-to Customer No." = field("No.");
                ApplicationArea = All;
            }

            part(SalesCreditMemosPart; Zyn_SalesCreditMemosSubpage)
            {
                SubPageLink = "Sell-to Customer No." = field("No.");
                ApplicationArea = All;
            }
        }
    }

}
