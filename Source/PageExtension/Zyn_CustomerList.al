pageextension 50133 Zyn_CustomerListExtension extends "Customer List"
{

    layout
    {
        addlast(factboxes)
        {


            part(CustomerStats; Zyn_CustomerStatsFactBox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
            part(ActiveSubscriptionstatus; Zyn_SubscriptionFactbox)
            {
                ApplicationArea = All;
                //SubPageLink="No."=field("No.");
            }
        }
    }



    actions
    {
        addlast(processing)
        {
            action(Empty)
            {
                ApplicationArea = All;
                Image = Report;
                // RunObject = report AmountReplaced;
            }
        }
    }
}

//need to check the Amount replaced report 