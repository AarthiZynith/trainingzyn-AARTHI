page 50140 Zyn_CustomerStatsFactBox
{
    Caption = 'CustomerStatsFactBox';
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group("Contact Information")
            {
                Visible = showContactInfo;
                field("Contact ID"; Rec."Primary Contact No.")
                {

                }
                field("Contact Name"; Rec.Contact)
                {

                }
            }
            group("Sales Information")
            {
                field("Open Sales Orders"; OpenSalesOrdersCount)
                {

                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
                        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
                        PAGE.Run(PAGE::"Sales Order List", SalesHeader);
                    end;
                }
                field("Open Sales Invoices"; OpenSalesInvoicesCount)
                {
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        SalesInvoiceHeader: Record "Sales Header";
                    begin
                        SalesInvoiceHeader.SetRange("Document Type", SalesInvoiceHeader."Document Type"::Invoice);
                        SalesInvoiceHeader.SetRange("Sell-to Customer No.", Rec."No.");
                        SalesInvoiceHeader.SetRange(Status, SalesInvoiceHeader.Status::Open);
                        PAGE.Run(PAGE::"Sales Invoice List", SalesInvoiceHeader);
                    end;
                }
            }
        }
    }

    var
        OpenSalesOrdersCount: Integer;
        OpenSalesInvoicesCount: Integer;
        showContactInfo: Boolean;

    trigger OnAfterGetRecord()
    var
        SalesHeader: Record "Sales Header";
    begin

        ShowContactInfo := (Rec."Primary Contact No." <> '') and (Rec.Contact <> '');

        // Open Sales Orders
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
        OpenSalesOrdersCount := SalesHeader.Count();

        // Open Sales Invoices
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
        OpenSalesInvoicesCount := SalesHeader.Count();

    end;
}
