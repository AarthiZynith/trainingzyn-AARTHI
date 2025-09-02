page 50115 ReadonlyContactsList
{
    PageType = List;
    SourceTable = Contact;
   // SourceTableTemporary = true;
    InsertAllowed = false;
    Editable = false;
    ApplicationArea = All;
    //Caption = 'Readonly Contact List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                // Add other fields you need
            }
        }
    }

    /* actions
     {
         // No actions defined to keep it read-only
     }*/
}
