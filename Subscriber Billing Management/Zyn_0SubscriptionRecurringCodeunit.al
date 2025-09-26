codeunit 50210 Zyn_SubscriptionInvoices
{
    trigger OnRun()
    begin
        CreateRecurringInvoices(WorkDate());
    end;

    procedure CreateRecurringInvoices(BillDate: Date)
    var
        SubRec: Record Zyn_CustomerSubscription;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        PlanRec: Record Zyn_PlanTable;
        LineNo: Integer;
    begin
        SubRec.SetRange(Status, SubRec.Status::Active);
        SubRec.SetRange("Next Bill Date", BillDate);
        if SubRec.FindSet() then
            repeat
                if not PlanRec.Get(SubRec."Plan ID") then
                    Error('Plan %1 not found for Subscription %2', SubRec."Plan ID", SubRec."Subscription ID");
                SalesHeader.Init();
                SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Invoice);
                SalesHeader.Validate("Sell-to Customer No.", SubRec."Customer ID");
                SalesHeader."From Subscription" := true;
                SalesHeader.Validate("Posting Date", BillDate);
                SalesHeader.Validate("Document Date", BillDate);
                SalesHeader.Insert(true);
                LineNo := 10000;
                SalesLine.Init();
                SalesLine.Validate("Document Type", SalesHeader."Document Type");
                SalesLine.Validate("Document No.", SalesHeader."No.");
                SalesLine.Validate("Line No.", LineNo);
                SalesLine.Validate(Type, SalesLine.Type::Item);
                SalesLine.Validate("No.", '4000');
                SalesLine.Validate(Quantity, 1);
                SalesLine.Validate("Unit Price", PlanRec.PlanFee);
                SalesLine.Insert(true);
                SubRec."Next Bill Date" := CalcDate('<+1M>', SubRec."Next Bill Date");
                if (SubRec."End Date" <> 0D) and (SubRec."Next Bill Date" > SubRec."End Date") then begin
                    SubRec.Status := SubRec.Status::Expired;
                    SubRec."Next Bill Date" := 0D;
                end;
                SubRec.Modify(true);
            until SubRec.Next() = 0;
    end;


}
