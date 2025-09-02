table 50152 RecurringExpenses
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryNo; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement=true;
            
        }
        field(2; Category; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = ExpenseCategory;
        }
        field(3; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Cycle; Enum recurring_Cycle)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcNextCycleDate();
            end;
        }
        field(5; NextCycleDate; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; StartDate; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CalcNextCycleDate();
            end;
        }
    }




    keys
    {
        key(PK; EntryNo)
        {
            Clustered = true;
        }
    }



    local procedure CalcNextCycleDate()
    begin
        if (StartDate = 0D) /*or (Cycle = Cycle::"") */then
            exit;

        case Cycle of
            Cycle::Weekly:
                NextCycleDate := CalcDate('<+1W>', StartDate);
            Cycle::Monthly:
                NextCycleDate := CalcDate('<+1M>', StartDate);
            Cycle::Quarterly:
                NextCycleDate := CalcDate('<+3M>', StartDate);
            Cycle::HalfYearly:
                NextCycleDate := CalcDate('<+6M>', StartDate);
            Cycle::Yearly:
                NextCycleDate := CalcDate('<+1Y>', StartDate);
        end;
    end;

}