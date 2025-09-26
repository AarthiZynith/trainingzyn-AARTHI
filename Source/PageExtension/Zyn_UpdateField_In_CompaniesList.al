pageextension 50132 Zyn_CompaniesListExt extends "Companies"
{
    layout
    {

    }
    actions
    {
        addlast(processing) // Adds a new action group to the "Navigation" menu
        {
            action(CustomTools)
            {
                Caption = 'Update Field';
                Image = View;
                ApplicationArea = All;
                RunObject = page Zyn_UpdateFieldDialog;

            }
        }
    }

}
