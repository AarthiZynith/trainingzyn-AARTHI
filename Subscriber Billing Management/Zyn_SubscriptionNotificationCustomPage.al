page 50213 Zyn_NotificationCustomPage
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable =NotificationCustomTable ;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
            }
        }
    }
    trigger OnOpenPage()
    var 
    NotificationCodeUnit: Codeunit "Zyn_NotificationCodeunit";
    begin
        NotificationCodeUnit.NotifySubscriptionTasks();
    end;
}