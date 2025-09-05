page 50204 SubscriptionPlanCardPage
{
    PageType = card;
    ApplicationArea = All;
   // UsageCategory = Administration;
    SourceTable = PlanTable;
   
    layout
    {
        area(Content)
        {
            group(GroupName)
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
    
   
}