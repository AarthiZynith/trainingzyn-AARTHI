page 50102 Zyn_FieldValueList
{
    Caption='FieldValueList';
    PageType = List;
    SourceTable = Zyn_FieldValueBuffer;
    SourceTableTemporary = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Field Name"; rec."Field Name")
                {
                                
                }
                field("Record Id"; rec."Record Id")
                {
                    
                }
                field("Field Id"; rec."Field Id")
                {
                   
                }
            }

        }
    }
}

