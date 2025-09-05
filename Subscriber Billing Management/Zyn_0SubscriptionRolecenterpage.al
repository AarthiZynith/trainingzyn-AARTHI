page 50221 "Subscription Cue Page"
{
    PageType = CardPart;
    SourceTable = "Subscription Cue";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            cuegroup("Subscription KPIs")
            {
                field("Active Subscriptions";active)
                {
                    ApplicationArea = All;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        SubPage: Page "SubscriptionListPage";
                        SubRec: Record "Customer Subscription";
                    begin
                        SubRec.SetRange(Status, SubRec.Status::Active);
                        SubPage.SetTableView(SubRec);
                        SubPage.Run();
                    end;
                }

                field("Revenue Generated"; RevenueGenerated())
                {
                    ApplicationArea = All;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        SalesHdr: Record "Sales Header";
                    begin
                        SalesHdr.Reset();
                        SalesHdr.SetRange("From Subscription", true);
                        SalesHdr.SetRange("Document Type", SalesHdr."Document Type"::Invoice);
                        SalesHdr.SetRange("Document Date", CalcDate('<-CM>', WorkDate()), CalcDate('<CM>', WorkDate()));

                        Page.RunModal(Page::"Sales Invoice List", SalesHdr);
                    end;
                }
            }
        }
    }

    local procedure RevenueGenerated(): Decimal
    var
        Cue: Record "Subscription Cue";
    begin
        if Cue.Get(1) then
            exit(Cue."Revenue Generated")
        else
            exit(0);
    end;


    trigger OnOpenPage()
    var
        Cue: Record "Subscription Cue";
        SalesHdr: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Revenue: Decimal;
        StartDate: Date;
        EndDate: Date;
    begin
        // Ensure Cue record exists
        if not Cue.Get(1) then begin
            Cue.Init();
            Cue."Primary Key" := 1;
            Cue.Insert();
        end;

        // Current month range
        StartDate := DMY2Date(1, Date2DMY(WorkDate(), 2), Date2DMY(WorkDate(), 3));
        EndDate := CalcDate('<CM>', WorkDate());

        Revenue := 0;
        SalesHdr.Reset();
        SalesHdr.SetRange("From Subscription", true);
        SalesHdr.SetRange("Document Type", SalesHdr."Document Type"::Invoice);
        SalesHdr.SetRange("document Date",CalcDate('<-CM>', WorkDate()), CalcDate('<CM>', WorkDate()));


        // if SalesHdr.FindSet() then
        //     repeat
                // SalesLine.Reset();
                // SalesLine.SetRange("Document Type", SalesHdr."Document Type");
                // SalesLine.SetRange("Document No.", SalesHdr."No.");
                // SalesLine.SetRange("Posting Date", StartDate, EndDate);

                if SalesHdr.FindSet() then
                    repeat
                        SalesHdr.CalcFields(Amount);
                        Revenue += SalesHdr.Amount;
                    until SalesHdr.Next() = 0;
            // until SalesHdr.Next() = 0;

        Cue."Revenue Generated" := Revenue;
        Cue.Modify(true);
    end;
    trigger OnAfterGetCurrRecord()
    var
    SubRec: Record "Customer Subscription";
    begin
        SubRec.Reset();
        SubRec.SetRange(Status, SubRec.Status::Active);
        active:=SubRec.Count;

    end;


    var
        Revenue: Decimal;
        active:Integer;
}
