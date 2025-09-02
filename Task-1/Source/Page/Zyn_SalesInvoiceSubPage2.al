page 50141 SalesInvoiceSubPageextn2{
    PageType=ListPart;
    SourceTable=SalesInvoiceSubpageExt;
    layout{
        area(Content){
            repeater(group){
                field("Language Code";rec."Language Code"){
                    ApplicationArea=All;
                }
                field("Description";rec.Description){
                    ApplicationArea=All;
                }
                field(Text;Rec.Text){
                    ApplicationArea=All;
                }
                field("Document Type";Rec."Document Type"){
                    ApplicationArea=All;
                }
                field(Bold;Rec.Bold){
                    ApplicationArea=All;
                }
                field(Italic;Rec.Italic){
                    ApplicationArea=All;
                }
                field("Under Line";Rec."Under Line"){
                    ApplicationArea=All;
                }
            
            }
        }
    }
}