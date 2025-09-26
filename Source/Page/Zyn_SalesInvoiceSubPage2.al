page 50141 Zyn_SalesInvoiceListPart
{
    Caption = 'SalesInvoiceListPart';
    PageType = ListPart;
    ApplicationArea=All;
    SourceTable = Zyn_SalesInvoiceSubpageExt;
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