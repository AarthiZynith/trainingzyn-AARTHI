page 50145 Zyn_SalesInvoiceSubPageextn
{
    Caption = 'SalesInvoiceSubPageExt';
    PageType = ListPart;
    SourceTable = Zyn_SalesInvoiceSubpageExt;
    ApplicationArea=All;
    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Language Code"; rec."Language Code")
                {

                }
                field("Description"; rec.Description)
                {

                }
                field(Text; Rec.Text)
                {

                }
                field("Document Type"; Rec."Document Type")
                {

                }
                field(Bold; Rec.Bold)
                {

                }
                field(Italic; Rec.Italic)
                {

                }
                field("Under Line"; Rec."Under Line")
                {

                }

            }
        }
    }
}