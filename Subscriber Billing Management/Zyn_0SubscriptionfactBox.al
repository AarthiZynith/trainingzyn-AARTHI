page 50211 SubscriptionFactbox
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
                field("ActiveSubscriptions";GetActiveSubscriptions())
                {
                   ApplicationArea=All;
                   DrillDown=true;
                   trigger OnDrillDown() 
                   var subpage:Page SubscriptionListPage;
                       subtable:record "Customer Subscription";
                   begin
                    subtable.SetRange("Customer ID",rec."No.");
                    subtable.SetRange(Status,subtable.Status::Active);
                    subpage.SetTableView(subtable);
                    subpage.Run();
                
                   end;
                }
            }
        }
    }
    local procedure GetActiveSubscriptions(): Integer
    var 
    customerSubscription:Record "Customer Subscription";
    begin
       customerSubscription.Reset();
       customerSubscription.SetRange("Customer ID",rec."No.");
       customerSubscription.SetRange(Status,customerSubscription.Status::Active);
       exit(customerSubscription.Count);
    end;
    
    
}