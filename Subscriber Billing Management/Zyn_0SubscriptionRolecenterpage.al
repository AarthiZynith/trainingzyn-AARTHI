page 50221 Zyn_SubscriptionCuePage
{
    PageType = CardPart;
    SourceTable = Zyn_SubscriptionCue;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            cuegroup("Subscription KPIs")
            {
                field("Active Subscriptions"; active)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        SubPage: Page Zyn_SubscriptionList;
                        SubRec: Record Zyn_CustomerSubscription;
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
        Cue: Record Zyn_SubscriptionCue;
    begin
        if Cue.Get(1) then
            exit(Cue."Revenue Generated")
        else
            exit(0);
    end;

    trigger OnOpenPage()
    var
        Cue: Record ZYn_SubscriptionCue;
        SalesHdr: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Revenue: Decimal;
        StartDate: Date;
        EndDate: Date;
    begin
        if not Cue.Get(1) then begin
            Cue.Init();
            Cue."Primary Key" := 1;
            Cue.Insert();
        end;
        StartDate := DMY2Date(1, Date2DMY(WorkDate(), 2), Date2DMY(WorkDate(), 3));
        EndDate := CalcDate('<CM>', WorkDate());
        Revenue := 0;
        SalesHdr.Reset();
        SalesHdr.SetRange("From Subscription", true);
        SalesHdr.SetRange("Document Type", SalesHdr."Document Type"::Invoice);
        SalesHdr.SetRange("document Date", CalcDate('<-CM>', WorkDate()), CalcDate('<CM>', WorkDate()));
        if SalesHdr.FindSet() then
            repeat
                SalesHdr.CalcFields(Amount);
                Revenue += SalesHdr.Amount;
            until SalesHdr.Next() = 0;
        Cue."Revenue Generated" := Revenue;
        Cue.Modify(true);
    end;

    trigger OnAfterGetCurrRecord()
    var
        SubRec: Record Zyn_CustomerSubscription;
    begin
        SubRec.Reset();
        SubRec.SetRange(Status, SubRec.Status::Active);
        active := SubRec.Count;
    end;

    var
        Revenue: Decimal;
        active: Integer;


}
