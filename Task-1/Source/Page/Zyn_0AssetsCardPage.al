page 50188 AssetsCardPage
{
    PageType = Card;
    ApplicationArea = All;
    //UsageCategory = Administration;
    SourceTable = Assets;
    
    layout
    {
        area(Content)
        {
            Group(General)
            {
                field(AssetTypes;Rec.AssetTypes)
                {
                   ApplicationArea=All; 
                }
                field(SerialNo;Rec.SerialNo){ApplicationArea=All;}
                field(ProcuredDate;Rec.ProcuredDate){ApplicationArea=All;}
                field(Vendor;Rec.Vendor){ApplicationArea=All;}
                field(Availability;Rec.Availability){
                    ApplicationArea=All;
                }
            }
        }
    }
    
//     actions
//     {
//         area(Processing)
//         {
//             action(ActionName)
//             {
                
//                 trigger OnAction()
//                 begin
                    
//                 end;
//             }
//         }
//     }
    
//     var
//         myInt: Integer;
// 
}