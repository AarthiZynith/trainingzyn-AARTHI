page 50186 AssetTypeListPage
{
    Caption='AssetTypeList';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = AssetType;
    CardPageId=AssetTypeCardPage;
     InsertAllowed=false;
    // ModifyAllowed=false;
    Editable=false;
  
    layout
    {
        area(Content)
        {
            Repeater(Group)
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
