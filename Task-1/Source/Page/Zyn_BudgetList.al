
page 50135 BudgetList
{
    PageType=List;
    ApplicationArea=All;
    UsageCategory=Lists;
    SourceTable=budget;
    //Editable=false;
    ModifyAllowed=false;
    InsertAllowed=false;
    CardPageId=BudgetCard;
    layout{
        area(content){
            repeater(group){
                field(BudgetID;Rec.BudgetID){
                    ApplicationArea=All;
                }
                field(FromDate;Rec.FromDate){
                    ApplicationArea=All;
                }
                field(ToDate;Rec.ToDate){
                    ApplicationArea=All;
                }
                field(CategoryName;Rec.CategoryName){
                    ApplicationArea=All;
                }
                field(Amount;Rec.Amount){
                    ApplicationArea=All;
                }
                
            }
        }

    }
}