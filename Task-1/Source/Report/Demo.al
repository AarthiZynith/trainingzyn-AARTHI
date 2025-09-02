report 50101 "MyReport"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly=true;

    dataset
    {
        dataitem(Cust; Customer)
        {
           // DataItemTableView = where(Name = const('')); // Placeholder, dynamic filtering used


            trigger OnAfterGetRecord()
            begin
                if Cust.Name = OldName then begin
                    Cust.Name := NewName;
                    Cust.Modify(true);
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Name Change")
                {
                    field("Old Name"; OldName)
                    {
                        ApplicationArea = All;
                    }
                    field("New Name"; NewName)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }



    var
        OldName: Text[100];
        NewName: Text[100];
}
