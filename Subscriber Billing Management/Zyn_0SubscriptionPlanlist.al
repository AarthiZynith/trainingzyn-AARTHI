page 50203 SubscriptionPlanlist
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = PlanTable;
    Editable=false;
    InsertAllowed=true;
    CardPageId=SubscriptionPlanCardPage;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(PlanID;Rec.PlanID)
                {
                    ApplicationArea=All;
                }
                field(PlanName;Rec.PlanName){ApplicationArea=All;}
                field(PlanFee;Rec.PlanFee){ApplicationArea=All;}
                field(Status;Rec.Status){ApplicationArea=All;}
                field(Description;Rec.Description){ApplicationArea=All;}
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
                var SubscriptionListapge:page SubscriptionListPage;
                begin
                    SubscriptionListapge.RunModal();
                end;
            }
        }
    }
    
   
}