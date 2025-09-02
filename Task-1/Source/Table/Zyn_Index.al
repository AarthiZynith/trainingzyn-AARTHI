table 50139 index 
{
fields{
    field(1;code;code[100]){
        DataClassification=ToBeClassified;
    }
    field(2;description;text[100])
    {
        DataClassification=ToBeClassified;
    }
    field(3;PercentageIncrease;Decimal){
        DataClassification=ToBeClassified;
    }
    field(4;StartYear;Integer)
    {
        DataClassification=ToBeClassified;
    }
    field(5;EndYear;Integer)
    {
        DataClassification=ToBeClassified;
    }
}



keys{
    key(PK;code){
        Clustered=true;
    }
}
}