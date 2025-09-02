page 50112 "Customer Modify Log List"
{
    PageType = List;
    SourceTable = "Customer Modify Log";
    Caption = 'Customer Modification Log';
    Editable = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(" Entry No."; rec."Entry No.") { ApplicationArea = all; }
                field("Customer No."; rec."Customer No.") { ApplicationArea = all; }
                field("Field Name"; rec."Field Name") { ApplicationArea = all; }
                field("Old Value"; rec."Old Value") { ApplicationArea = all; }
                field("New Value"; rec."New Value") { ApplicationArea = all; }
                field("User ID"; rec."User ID") { ApplicationArea = all; }
                field("Modified On"; rec."Modified On") { ApplicationArea = all; }
            }
        }
    }


}
