page 50167 Zyn_leaveCategoryList
{
    Caption = 'LeaveCategoryList';
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_LeaveCategory;
    CardPageId = Zyn_leaveCategorycard;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
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