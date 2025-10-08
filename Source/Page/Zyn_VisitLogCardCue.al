page 50127 Zyn_TodayVisitorsCuePart
{
    PageType = CardPart;
    SourceTable = Zyn_VisitLog;
    ApplicationArea = All;
    Caption = 'Visit Stats';

    layout
    {
        area(content)
        {
            cuegroup("Visitors")
            {
                field(TodayVisitors; TodayVisitorsCount)
                {
                    ApplicationArea = All;
                    Caption = 'Today''s Visitors';
                    DrillDown = true;
                    DrillDownPageId = Zyn_VisitLogList;

                    trigger OnDrillDown()
                    var
                        Visit: Record Zyn_VisitLog;
                        Customer: Record Customer;
                        Tempcustomer: Record Customer temporary;

                    begin
                        Visit.Reset();
                        Visit.SetRange("Visit Date", WorkDate());
                        if Visit.FindSet() then begin
                            repeat
                                if Customer.Get(Visit."Customer No.") then begin
                                    if not Tempcustomer.Get(Visit."Customer No.") then begin
                                        Tempcustomer := Customer;
                                        Tempcustomer.Insert();
                                    end;
                                end;
                            until Visit.Next() = 0;
                        end;
                        Page.RunModal(Page::"Customer List", Tempcustomer);

                    end;

                }
            }
        }
    }
    var
        count: Integer;

    trigger OnOpenpage()
    begin
        count := TodayVisitorsCount();
    end;

    local procedure TodayVisitorsCount(): Integer

    var
        VisitLog: Record Zyn_VisitLog;
        Today: Date;
        countt: Integer;
    begin
        Today := WorkDate();
        VisitLog.SetRange("Visit Date", Today);
        Count := VisitLog.Count();
        exit(Count);
    end;
}
