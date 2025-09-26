page 50211 Zyn_SubscriptionFactbox
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = customer;

    layout
    {
        area(Content)
        {
            cuegroup(GroupName)
            {
                field("ActiveSubscriptions"; GetActiveSubscriptions())
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        subpage: Page Zyn_SubscriptionList;
                        subtable: record Zyn_CustomerSubscription;
                    begin
                        subtable.SetRange("Customer ID", rec."No.");
                        subtable.SetRange(Status, subtable.Status::Active);
                        subpage.SetTableView(subtable);
                        subpage.Run();

                    end;
                }
            }
        }
    }
    local procedure GetActiveSubscriptions(): Integer
    var
        customerSubscription: Record Zyn_CustomerSubscription;
    begin
        customerSubscription.Reset();
        customerSubscription.SetRange("Customer ID", rec."No.");
        customerSubscription.SetRange(Status, customerSubscription.Status::Active);
        exit(customerSubscription.Count);
    end;


}