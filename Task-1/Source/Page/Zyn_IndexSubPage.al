page 50103 IndexSubpage
{
    PageType=ListPart;
    SourceTable=IndexSubpagetable;
    ApplicationArea=All;
    Editable=false;

    layout{
        area(content){
            repeater(group){
                
                field(Year;Rec.Year){
                    ApplicationArea=All;
                }
                field(value;Rec.value){
                    ApplicationArea=All;
                }
            }
        }
    }
} 