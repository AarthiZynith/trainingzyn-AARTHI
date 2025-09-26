page 50104 Zyn_Indexcard
{
    Caption = 'IndexCard';
    PageType = Card;
    SourceTable = Zyn_Index;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(general)
            {
                field(code; Rec.code)
                {

                }
                field(description; Rec.description)
                {

                }
                field(PercentageIncrease; Rec.PercentageIncrease)
                {
                    trigger OnValidate()
                    begin
                        if (Rec.StartYear <> 0) and (Rec.EndYear <> 0) and (Rec.PercentageIncrease <> 0) then
                            CalculateValues();
                    end;
                }
                field(StartYear; Rec.StartYear)
                {
                    trigger OnValidate()
                    begin
                        if (Rec.StartYear <> 0) and (Rec.EndYear <> 0) and (Rec.PercentageIncrease <> 0) then
                            CalculateValues();
                    end;
                }
                field(EndYear; Rec.EndYear)
                {

                    trigger OnValidate()
                    begin
                        if (Rec.StartYear <> 0) and (Rec.EndYear <> 0) and (Rec.PercentageIncrease <> 0) then
                            CalculateValues();
                    end;
                }
            }
            part("IndexSubpage"; Zyn_IndexSubpage)
            {
                ApplicationArea = All;
                SubPageLink = code = field(code);
            }
        }
    }

    local procedure CalculateValues()
    var
        SubRec: Record Zyn_IndexSubpage;
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
        SubRec: Record Zyn_IndexSubpage;
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
        SubRec: Record Zyn_IndexSubpage;
    begin
        SubRec.Reset();
        SubRec.SetRange(code, CodeValue);
        if SubRec.FindLast() then
            exit(SubRec.EntryNo + 1)
        else
            exit(1);
    end;
}
