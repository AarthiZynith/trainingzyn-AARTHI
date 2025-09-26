page 50208 Zyn_SubscriptionCard
{
    PageType = card;
    ApplicationArea = All;
    SourceTable = Zyn_CustomerSubscription;

    layout
    {
        area(Content)
        {
            group(General)
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

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}