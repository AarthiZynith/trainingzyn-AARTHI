pageextension 50132 CompaniesListExt extends "Companies"
{
    layout { }
    actions
    {
        addlast(processing) // Adds a new action group to the "Navigation" menu
        {
            action(CustomTools)
            {
                Caption = 'Update Field';
                Image = View;
                ApplicationArea = All;

                RunObject=page "Update Field Dialog";
 
}
        }
    }
    
}
