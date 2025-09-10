codeunit 50211 "Zyn_NotificationCodeunit"
{
    procedure NotifySubscriptionTasks()
    var
        notification: Notification;
        subscriptionTask: Record "Customer Subscription";
        MessageText: Text;
        TodayDate: Date;
        TargetDate: Date;
    begin
        TodayDate := WorkDate();
        TargetDate := CalcDate('<+15D>', TodayDate); // 15 days from today

        subscriptionTask.Reset();
        subscriptionTask.SetRange(Status, subscriptionTask.Status::Active);
       // subscriptionTask.SetRange("End Date", 0D, TargetDate); // End Date <= TargetDate

        if subscriptionTask.FindSet() then begin
            repeat
                if (subscriptionTask."End Date" = TargetDate) then begin


                    MessageText := StrSubstNo(
                        'Subscription %1 for %2 is ending on %3',
                        subscriptionTask."Subscription ID",
                        subscriptionTask."Customer ID",
                        Format(subscriptionTask."End Date"));

                    notification.Id := CreateGUID();
                    notification.Scope := NotificationScope::LocalScope;
                    notification.Message := MessageText;
                    notification.Send();
                end;
            until subscriptionTask.Next() = 0;
        end else begin
            notification.Id := CreateGUID();
            notification.Scope := NotificationScope::LocalScope;
            notification.Message := 'No subscriptions ending within 15 days!';
            notification.Send();
        end;
    end;
}
