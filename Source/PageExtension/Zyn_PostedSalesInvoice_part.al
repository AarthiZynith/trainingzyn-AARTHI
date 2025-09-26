pageextension 50136 Zyn_PostedInvoiceExt extends "Posted Sales Invoice"
{
    layout
    {
        addlast(Content)
        {
            part("Beginning Text Details"; Zyn_SalesInvoiceSubPageextn)
            {
                ApplicationArea = All;
                SubPageLink =
                              "No." = field("No."),
                              "Enum Method" = const(Zyn_BeginEndText::BeginText);
                Editable = false;
            }
            part("Ending Text Details"; Zyn_SalesInvoiceSubPageextn)
            {
                ApplicationArea = All;
                SubPageLink =
                            "No." = field("No."),
                            "Enum Method" = const(Zyn_BeginEndText::EndText);
                Editable = false;
            }
        }
    }
}