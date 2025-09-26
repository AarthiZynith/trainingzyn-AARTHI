pageextension 50171 Zyn_Extension extends "O365 Activities"
{
    layout
    {

    }
    actions
    {

    }
    trigger OnOpenPage()
    var
        Notification_: Codeunit "Zyn_LeaveRequestNotification";
    begin
        Notification_.LeaveApprovalNotification();
    end;
}