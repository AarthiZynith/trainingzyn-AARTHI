page 50102 "Field Value List"
{
    PageType = List;
    SourceTable = "FieldValueBuffer";
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
                    Caption = 'Field Value';
                    ApplicationArea = All;
                }

                 field("Record Id"; rec."Record Id") { 
                    ApplicationArea = All;
                 }

                 field( "Field Id"; rec."Field Id") { 
                     ApplicationArea = All;
                 }
    }

            }
        }
    }

