report 50135 "Posted sales invoice report"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    ApplicationArea = All;
    Caption = 'Posted sales invoice report';
    RDLCLayout = './Source/Report/SalesHeader.rdl';

    dataset
    {


        dataitem("SalesInvoiceHeader"; "Sales Invoice Header")
        {
            column("No"; "No.") { }
            column("SellToCustomername"; "Sell-to Customer Name") { }
            column("PostingDate"; "Posting Date") { }
            column("DocumentDate"; "Document Date") { }

            dataitem("Company Information"; "Company Information")
            {
                column(CompanyName; CompanyName) { }
                column(Address; Address) { }
                column("Companylogo"; Picture) { }
            }

            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Description; Description) { }
                column(Line_Amount; "Line Amount") { }
                column(Quantity; Quantity) { }
                column(Line_No_; "Line No.") { }
            }


            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Document No." = field("No."), "Customer No." = field("Sell-to Customer No.");
                column("LedgerDescription"; Description) { }
                column(Amount; Amount) { }
                column(Remaining_Amount; "Remaining Amount") { }
            }

            dataitem("SalesInvoiceSubPage"; SalesInvoiceSubpageExt)
            {
                DataItemLink = "No." = field("No."); // Link to Sales Invoice Header No.
                column(Text; Text) { }
                column(Enum_Method; "Enum Method") { }
            }
        }
    }
}
