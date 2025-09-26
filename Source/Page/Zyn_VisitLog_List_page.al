page 50122 Zyn_VisitLogList
{
    PageType = List;
    SourceTable = Zyn_VisitLog;
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Visit Log List';
    CardPageId = Zyn_VisitLogCard;
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
                   
                }
                field("Visit Date"; rec."Visit Date")
                {
                    
                }
                field("Purpose"; rec."Purpose")
                {
                    
                }
                field("Notes"; rec."Notes")
                {
                   
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









