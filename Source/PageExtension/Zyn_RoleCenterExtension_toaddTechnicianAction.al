pageextension 50135 Zyn_ReoleCenterExt extends "Business Manager Role Center"
{

    actions
    {

        addlast(embedding)
        {
            action(Technician)
            {
                RunObject = page Zyn_TechnicianList;
                ApplicationArea = All;
            }
        }
    }





}