page 50115 Zyn_ReadonlyContactsList
{
    PageType = List;
    SourceTable = Contact;
    InsertAllowed = false;
    Editable = false;
    ApplicationArea = All;
    Caption = 'Readonly Contact List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                   
                }
                field(Name; rec.Name)
                {
                   
                }
                field("E-Mail"; rec."E-Mail")
                {
                  
                }
                field("Phone No."; rec."Phone No.")
                {
                   
                }

            }
        }
    }

}
