pageextension 50134 CustomerCardExtension extends "Customer Card"
{
    actions
    {
        addlast(processing)
        {
            action(VisitLog)
            {
                ApplicationArea = All;
                Caption = 'Visit Log';
                Image = View;

                trigger OnAction()
                var
                    "LogListPage": Page "Visit Log List";
                begin
                    LogListPage.SetCustomerNo(Rec."No.");// this method is to  pass the data of one page into another page 
                    LogListPage.RunModal();
                end;
            }
        }
    }
}
 