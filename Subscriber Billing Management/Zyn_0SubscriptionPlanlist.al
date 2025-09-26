page 50203 Zyn_SubscriptionPlanlist
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Zyn_PlanTable;
    Editable = false;
    InsertAllowed = true;
    CardPageId = Zyn_SubscriptionPlanCard;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(PlanID; Rec.PlanID)
                {

                }
                field(PlanName; Rec.PlanName)
                {
                    
                }
                field(PlanFee; Rec.PlanFee)
                {
                    
                }
                field(Status; Rec.Status)
                {
                    
                }
                field(Description; Rec.Description)
                {
                    
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SubscriptionList)
            {

                trigger OnAction()
                var
                    SubscriptionListapge: page Zyn_SubscriptionList;
                begin
                    SubscriptionListapge.RunModal();
                end;
            }
        }
    }


}