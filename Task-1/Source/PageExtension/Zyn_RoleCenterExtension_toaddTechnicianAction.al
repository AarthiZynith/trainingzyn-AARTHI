pageextension 50135 ReoleCenterExt extends "Business Manager Role Center"
{

    actions
    {

        addlast(embedding)
        {
            action(Technician)
            {
                RunObject = page "TechnicianListPage";
                ApplicationArea = All;
                 

            }
        }
    }





}