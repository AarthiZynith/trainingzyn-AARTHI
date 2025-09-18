page 50167 leaveCategoryList
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = LeaveCategoryTable;
    CardPageId=leaveCategorycard;
    InsertAllowed=false;
    ModifyAllowed=false;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(CategoryName;Rec.CategoryName)
                {
                    ApplicationArea=All;
                }
                field(Description;Rec.Description){
                    ApplicationArea=All;
                }
                field("No of Days Allowed";Rec."No of Days Allowed"){
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