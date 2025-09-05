table 50182 Assets
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; AssetTypes; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = AssetType.AssetID;

        }
        field(2; SerialNo; Code[100])
        {
            DataClassification = ToBeClassified;

        }
        field(3; ProcuredDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Vendor; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Availability; Boolean)
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // begin
            //     CalcAvailability();
            // end;
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
        // By default available
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
                    Error(
                      'The asset %1 exceeds 5 years from its procured date and cannot be assigned.',
                      SerialNo
                    )
                else
                    Availability := false; // Assigned but within 5 years
            end;
        end;
    end;




}