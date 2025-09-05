table 50180 AssetType
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;AssetID;Code[100]){
            DataClassification=ToBeClassified;
            //AutoIncrement=true;
        }
        field(2;Category;enum AssetTypeCategory)
        {
            DataClassification = ToBeClassified;
            
        }
        field(3;Name;Text[100]){
            DataClassification=ToBeClassified;
        }
    }
    
    keys
    {
        key(Pk;AssetID,Name)
        {
            Clustered = true;
        }
    }
    
    
    
}