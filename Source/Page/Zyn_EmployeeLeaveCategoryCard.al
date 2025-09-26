page 50168 Zyn_leaveCategorycard
{
    Caption = 'LeaveCategoryCard';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_LeaveCategory;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(CategoryName; Rec.CategoryName)
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("No of Days Allowed"; Rec."No of Days Allowed")
                {

                }
            }
        }
    }


}