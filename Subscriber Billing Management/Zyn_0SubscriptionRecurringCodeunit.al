codeunit 50210 "SubscriptionInvoices"
{
    trigger OnRun()
    begin
        CreateRecurringInvoices(WorkDate());
        // UpdateSubscriptionCue();
    end;

    procedure CreateRecurringInvoices(BillDate: Date)
    var
        SubRec: Record "Customer Subscription";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        PlanRec: Record PlanTable;
        LineNo: Integer;
    begin
        SubRec.SetRange(Status, SubRec.Status::Active);
        SubRec.SetRange("Next Bill Date", BillDate);

        if SubRec.FindSet() then
            repeat
                if not PlanRec.Get(SubRec."Plan ID") then
                    Error('Plan %1 not found for Subscription %2', SubRec."Plan ID", SubRec."Subscription ID");

                // Create Sales Header (Invoice)
                SalesHeader.Init();
                SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Invoice);
                SalesHeader.Validate("Sell-to Customer No.", SubRec."Customer ID");
                SalesHeader."From Subscription" := true;
                SalesHeader.Validate("Posting Date", BillDate);
                SalesHeader.Validate("Document Date", BillDate);
                SalesHeader.Insert(true);

                // Add Sales Line
                LineNo := 10000;
                SalesLine.Init();
                SalesLine.Validate("Document Type", SalesHeader."Document Type");
                SalesLine.Validate("Document No.", SalesHeader."No.");
                SalesLine.Validate("Line No.", LineNo);

                // Use Item or G/L Account properly
                SalesLine.Validate(Type, SalesLine.Type::Item);
                SalesLine.Validate("No.", '4000'); // <-- must exist as valid G/L Account
                SalesLine.Validate(Quantity, 1);
                SalesLine.Validate("Unit Price", PlanRec.PlanFee);
                SalesLine.Insert(true);

                // Update Next Bill Date
                SubRec."Next Bill Date" := CalcDate('<+1M>', SubRec."Next Bill Date");
                if (SubRec."End Date" <> 0D) and (SubRec."Next Bill Date" > SubRec."End Date") then begin
                    SubRec.Status := SubRec.Status::Expired;
                    SubRec."Next Bill Date" := 0D;
                end;

                SubRec.Modify(true);
            until SubRec.Next() = 0;
    end;

    // procedure UpdateSubscriptionCue()
    // var
    //     Cue: Record "Subscription Cue";
    //     SalesHdr: Record "Sales Header";
    //     SalesLine: Record "Sales Line";
    //     Revenue: Decimal;
    //     StartDate: Date;
    //     EndDate: Date;
    // begin
    //     // Ensure Cue record exists
    //     if not Cue.Get(1) then begin
    //         Cue.Init();
    //         Cue."Primary Key" := 1;
    //         Cue.Insert();
    //     end;

    //     // Current month range
    //     StartDate := DMY2Date(1, Date2DMY(WorkDate(), 2), Date2DMY(WorkDate(), 3));
    //     EndDate := CalcDate('<CM>', WorkDate());

    //     Revenue := 0;
    //     SalesHdr.Reset();
    //     SalesHdr.SetRange("From Subscription", true);
    //     SalesHdr.SetRange("Document Type", SalesHdr."Document Type"::Invoice);
    //     SalesHdr.SetRange("document Date", StartDate, EndDate);

    //     if SalesHdr.FindSet() then
    //         repeat
    //             SalesLine.Reset();
    //             SalesLine.SetRange("Document Type", SalesHdr."Document Type");
    //             SalesLine.SetRange("Document No.", SalesHdr."No.");
    //             SalesLine.SetRange("Posting Date", StartDate, EndDate);

    //             if SalesLine.FindSet() then
    //                 SalesHdr.CalcFields(Amount);
    //             repeat
    //                 Revenue += SalesLine.Amount;
    //             until SalesLine.Next() = 0;
    //         until SalesHdr.Next() = 0;

    //     Cue."Revenue Generated" := Revenue;
    //     Cue.Modify(true);
    // end;
}
