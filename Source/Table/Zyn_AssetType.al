table 50180 Zyn_AssetType
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; AssetID; Code[100])
        {
            Caption = 'AssetID';
            DataClassification = ToBeClassified;
        }
        field(2; Category; enum Zyn_AssetTypeCategory)
        {
            Caption = 'Category';
            DataClassification = ToBeClassified;
        }
        field(3; Name; Text[100])
        {
            Caption = ' Name';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Pk; AssetID, Name)
        {
            Clustered = true;
        }
    }

}