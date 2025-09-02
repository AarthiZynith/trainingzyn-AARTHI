codeunit 50170 "Leave Request Notification"
{
    procedure LeaveApprovalNotification()
    var
        notification: Notification;
        leaverequest: Record LeaveRequestTable;
    begin
        leaverequest.Reset();
        leaverequest.SetRange(Status, leaverequest.Status::Approved);
        leaverequest.SetCurrentKey(SystemModifiedAt);
        leaverequest.SetAscending(SystemModifiedAt, true);


        clear(notification);
        notification.id := 'CDEF7890-ABCD-0123-1234-567890ABCDEF';
        notification.Scope := NotificationScope::LocalScope;
        if leaverequest.FindLast() then
            notification.Message :=
            StrSubstNo('Leave Approved of %1 for %2 days.', leaverequest.EmployeeID, leaverequest.EndDate - leaverequest.StartDate + 1)
        else
            notification.message := 'No Approved Leave request!';

        notification.send();
    end;
}

