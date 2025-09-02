namespace DefaultPublisher.ALProject5;
page 50120 "Visit Manager Role Center"
{

    PageType = RoleCenter;
    Caption = 'Visit Manager';
    ApplicationArea = All;

layout{
    area(RoleCenter)
    {
    part( Customercuetile;50127)
    {

    }
    }
}
    
 actions{
    area(Embedding){
        action(Customers)
        {
            RunObject = Page "Visit Log List";
            ApplicationArea=All;
        }

    }
}
}