page 50122 "Visit Log List"
{
    PageType = List;
    SourceTable = "Visit Log";
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Visit Log List';
    CardPageId = "Visit Log card";
    InsertAllowed = false;
    editable = false;

    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("Customer No."; rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Visit Date"; rec."Visit Date")
                {
                    ApplicationArea = ll;
                }
                field("Purpose"; rec."Purpose")
                {
                    ApplicationArea = all;
                }
                field("Notes"; rec."Notes")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    var
        FilterCustomerNo: Code[20];

    procedure SetCustomerNo(CustomerNo: Code[20]) 
    begin
        FilterCustomerNo := CustomerNo;// store the customer no value into the filterCustomerNo
        Rec.SetRange("Customer No.", CustomerNo); // ✅ Proper way to filter the dataset
    end;
}
