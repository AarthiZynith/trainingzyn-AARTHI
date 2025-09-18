page 50168 leaveCategorycard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = LeaveCategoryTable;
    
    layout
    {
        area(Content)
        {
            group(GroupName)
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