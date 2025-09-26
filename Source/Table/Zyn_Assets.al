table 50182 Zyn_Assets
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; AssetTypes; code[100])
        {
            Caption = ' AssetTypes';
            DataClassification = ToBeClassified;
            TableRelation = Zyn_AssetType.AssetID;
        }
        field(2; SerialNo; Code[100])
        {
            Caption = 'SerialNo';
            DataClassification = ToBeClassified;
        }
        field(3; ProcuredDate; Date)
        {
            Caption = ' ProcuredDate';
            DataClassification = ToBeClassified;
        }
        field(4; Vendor; Text[100])
        {
            Caption = 'Vendor';
            DataClassification = ToBeClassified;
        }
        field(5; Availability; Boolean)
        {
            Caption = ' Availability';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; SerialNo, AssetTypes)
        {
            Clustered = true;
        }
    }
    local procedure CalcAvailability()
    var
        EmployeeAssetRec: Record EmployeeAsset;
        FiveYearsLater: Date;
    begin
        Availability := true;
        if (ProcuredDate = 0D) then begin
            Availability := false;
            exit;
        end;
        FiveYearsLater := CalcDate('<+5Y>', ProcuredDate);

        // Look for assignment record
        EmployeeAssetRec.Reset();
        EmployeeAssetRec.SetRange(Serial_No, SerialNo);
        if EmployeeAssetRec.FindFirst() then begin
            if EmployeeAssetRec.AssetStatus = EmployeeAssetRec.AssetStatus::Assigned then begin
                if EmployeeAssetRec.AssignedDate > FiveYearsLater then
                    Error(assestErrorCheck, SerialNo)
                else
                    Availability := false; // Assigned but within 5 years
            end;
        end;
    end;

    Var
        assestErrorCheck: Label 'The asset %1 exceeds 5 years from its procured date and cannot be assigned.';

}