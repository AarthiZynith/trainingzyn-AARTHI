page 50104 IndexcardPage
{
    PageType = Card;
    SourceTable = index;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(general)
            {
                field(code; Rec.code)
                {
                    ApplicationArea = All;
                }
                field(description; Rec.description)
                {
                    ApplicationArea = All;
                }
                field(PercentageIncrease; Rec.PercentageIncrease)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if (Rec.StartYear <> 0) and (Rec.EndYear <> 0) and (Rec.PercentageIncrease <> 0) then
                            CalculateValues();
                    end;
                }
                field(StartYear; Rec.StartYear)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if (Rec.StartYear <> 0) and (Rec.EndYear <> 0) and (Rec.PercentageIncrease <> 0) then
                            CalculateValues();
                    end;
                }
                field(EndYear; Rec.EndYear)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if (Rec.StartYear <> 0) and (Rec.EndYear <> 0) and (Rec.PercentageIncrease <> 0) then
                            CalculateValues();
                    end;
                }
            }
            part("IndexSubpage"; IndexSubpage)
            {
                ApplicationArea = All;
                SubPageLink = code = field(code);
            }
        }
    }

    local procedure CalculateValues()
    var
        SubRec: Record IndexSubpagetable;
        CurrYear: Integer;
        PrevValue: Decimal;
    begin
        // Clear old values
        SubRec.Reset();
        SubRec.SetRange(code, Rec.code);
        if SubRec.FindSet() then
            SubRec.DeleteAll();

        // First year value = 100
        CurrYear := Rec.StartYear;
        PrevValue := 100;
        InsertLine(Rec.code, CurrYear, PrevValue);

        // Loop from StartYear+1 to EndYear
        for CurrYear := Rec.StartYear + 1 to Rec.EndYear do begin
            PrevValue := PrevValue + (PrevValue * (Rec.PercentageIncrease / 100));
            InsertLine(Rec.code, CurrYear, PrevValue);
        end;
    end;

    local procedure InsertLine(CodeValue: Code[10]; YearValue: Integer; Amount: Decimal)
    var
        SubRec: Record IndexSubpagetable;
    begin
        SubRec.Init();
        SubRec.code := CodeValue;
        SubRec.EntryNo := GetNextEntryNo(CodeValue);
        SubRec.Year := YearValue;
        SubRec.value := Amount;
        SubRec.Insert();
    end;

    local procedure GetNextEntryNo(CodeValue: Code[10]): Integer
    var
        SubRec: Record IndexSubpagetable;
    begin
        SubRec.Reset();
        SubRec.SetRange(code, CodeValue);
        if SubRec.FindLast() then
            exit(SubRec.EntryNo + 1)
        else
            exit(1);
    end;
}
