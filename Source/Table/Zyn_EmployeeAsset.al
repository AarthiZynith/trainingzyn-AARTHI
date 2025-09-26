table 50184 EmployeeAsset
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EmployeeID; Integer)
        {
            Caption = 'EmployeeID';
            DataClassification = ToBeClassified;
            TableRelation = Zyn_EmployeeTable.EmployeeID;

        }
        field(2; AssetTypeName; TExt[100])
        {
            Caption = 'AssetTypeName';
            DataClassification = ToBeClassified;
            TableRelation = Zyn_AssetType.Name;
        }
        field(3; Serial_No; Code[100])
        {
            Caption = ' Serial_No';
            DataClassification = ToBeClassified;
            TableRelation = Zyn_Assets.SerialNo;
        }
        field(4; AssetStatus; Enum Zyn_EmployeeAssetStatus)
        {
            Caption = ' AssetStatus';
            DataClassification = ToBeClassified;

        }
        field(5; AssignedDate; Date)
        {
            Caption = 'AssignedDate';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                AssetRec: Record Zyn_Assets;
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
            Caption = 'ReturnedDate';
            DataClassification = ToBeClassified;
        }
        field(7; LostDate; Date)
        {
            Caption = 'LostDate';
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
        AssetRec: Record Zyn_Assets;
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