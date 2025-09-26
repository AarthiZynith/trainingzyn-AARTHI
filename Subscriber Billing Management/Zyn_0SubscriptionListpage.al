page 50207 Zyn_SubscriptionList
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Zyn_CustomerSubscription;
    Editable = false;
    InsertAllowed = true;
    CardPageId = Zyn_SubscriptionCard;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Subscription ID"; Rec."Subscription ID")
                {

                }
                field("Customer ID"; Rec."Customer ID")
                {

                }
                field("Plan ID"; Rec."Plan ID")
                {

                }
                field("Start Date"; Rec."Start Date")
                {

                }
                field("End Date"; Rec."End Date")
                {

                }
                field(Status; Rec.Status)
                {

                }
                field("Next Bill Date"; Rec."Next Bill Date")
                {

                }
            }
        }
    }


}