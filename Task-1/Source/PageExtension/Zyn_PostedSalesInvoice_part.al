pageextension 50136 "PostedInvoiceExt" extends "Posted Sales Invoice"
{
    layout
    {
        addlast(Content)
        {
            part("Beginning Text Details";SalesInvoiceSubPageextn)
            {
                ApplicationArea = All;
                //Editable = false;
                SubPageLink =
                              "No." = field("No."),
                              "Enum Method" = const(BeginEndText::BeginText);
                Editable = false;
            }
            part("Ending Text Details";SalesInvoiceSubPageextn)
            {
                ApplicationArea = All;
                SubPageLink =
                            "No." = field("No."),
                            "Enum Method" = const(BeginEndText::EndText);
                Editable = false;
            }
        }
    }
}