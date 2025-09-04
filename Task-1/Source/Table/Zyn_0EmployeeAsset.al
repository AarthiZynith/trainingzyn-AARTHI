table 50184 EmployeeAsset
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EmployeeID; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = EmployeeTable.EmployeeID;
            //AutoIncrement=true;
        }
        field(2; AssetTypeName; TExt[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = AssetType.Name;
        }
        field(3; Serial_No; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Assets.SerialNo;
        }
        field(4; AssetStatus; Enum EmployeeAssetStatus)
        {
            DataClassification = ToBeClassified;

        }
        field(5; AssignedDate; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                AssetRec: Record Assets;
                FiveyearsLater: Date;
            begin
                if (Serial_No <> '') and (AssignedDate <> 0D) then begin
                    if (AssetRec.get(Serial_No)) then begin
                        FiveyearsLater := CalcDate('<+5Y>', AssetRec.ProcuredDate);
                        if (AssignedDate > FiveyearsLater) then
                            Error('This asset procured on %1  exceed five years since it assinged on %2', AssetRec.ProcuredDate, AssignedDate);
                    end;
                end;
            end;
        }
        field(6; ReturnedDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; LostDate; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; EmployeeID, Serial_No)
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
begin
    UpdateAssetAvailability();
end;

trigger OnModify()
begin
    UpdateAssetAvailability();
end;

local procedure UpdateAssetAvailability()
var
    AssetRec: Record Assets;
begin
    if Serial_No = '' then
        exit;

    if AssetRec.Get(Serial_No) then begin
        case AssetStatus of
            AssetStatus::Assigned:
                AssetRec.Availability := false;
            AssetStatus::Returned:
                AssetRec.Availability := true;
            AssetStatus::Lost:
                AssetRec.Availability := false;
        end;
        AssetRec.Modify(true); // force update
    end;
end;



}