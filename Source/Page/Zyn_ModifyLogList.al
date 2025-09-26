page 50112 Zyn_CustomerModifyLogList
{
    PageType = List;
    SourceTable = Zyn_CustomerModifyLog;
    Caption = 'Customer Modification Log';
    Editable = false;
    InsertAllowed = false;
    ApplicationArea=All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(" Entry No."; rec."Entry No.")
                {
                    
                }
                field("Customer No."; rec."Customer No.")
                {
                   
                }
                field("Field Name"; rec."Field Name")
                {
                  
                }
                field("Old Value"; rec."Old Value")
                {
                    
                }
                field("New Value"; rec."New Value")
                {
                   
                }
                field("User ID"; rec."User ID")
                {
                    
                }
                field("Modified On"; rec."Modified On")
                {
                    
                }
            }
        }
    }


}
