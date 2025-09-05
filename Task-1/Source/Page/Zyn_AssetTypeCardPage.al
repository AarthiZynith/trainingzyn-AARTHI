page 50187 AssetTypeCardPage
{
    Caption='AssetTypeCard';
    PageType = Card;
    ApplicationArea = All;
   // UsageCategory = Administration;
    SourceTable = AssetType;
//     InsertAllowed=true ;
//    // ModifyAllowed=false;
//    Editable=false;
    
    layout
    {
        area(Content)
        {
            group(Group)
            {
                field(EntryNo;Rec.AssetID){ApplicationArea=All;}
                field(Category;Rec.Category)
                {
                    ApplicationArea=All;
                }
                field(Name;Rec.Name){
                    ApplicationArea=All;
                }
            }
        }
    }
    
    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {
                
    //             trigger OnAction()
    //             begin
                    
    //             end;
    //         }
    //     }
    // }
    
    // var
    //     myInt: Integer;
}