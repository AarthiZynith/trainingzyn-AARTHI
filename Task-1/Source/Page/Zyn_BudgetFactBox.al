page 50142 "Budget FactBox"
{
    PageType = ListPart;
    SourceTable = Budget;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("From Date"; Rec."FromDate") { }
                field("To Date"; rec."ToDate") { }
                field("CategoryName"; rec.CategoryName) { }
                field("Budget Amount"; rec.Amount) { }
            }
        }
    }

    // trigger OnOpenPage()
    // var
    //     CurrBud: Record "Budget";
    // begin
    //     // Load current month budget if exists
    //     if CurrBud.Get('BUD' + Format(Date2DMY(WORKDATE,2)) + Format(Date2DMY(WORKDATE,3))) then
    //         CurrPage.SetRecord(CurrBud);
    // end;
    trigger OnOpenPage()
    var
        start: Date;
        endin: Date;
    begin
        start := CalcDate('<-CM>', WorkDate());
        endin := CalcDate('<CD>', WorkDate());
        Rec.SetRange(FromDate, start, endin);
    end;
}
