pageextension 50171 Extension extends "O365 Activities"{
    layout{

    }
    actions{
        
    }
    trigger OnOpenPage()
    var 
    Notification_: Codeunit "Leave Request Notification";
    begin
        Notification_.LeaveApprovalNotification();
    end;
}