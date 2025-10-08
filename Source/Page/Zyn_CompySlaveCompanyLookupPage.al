page 50262 "Zyn_SlaveCompanyLookup"
{
    PageType = List;
    SourceTable = Zyn_Company;
    Caption = 'Select Slave Company';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {

                }
                field("Display Name"; Rec."Display Name")
                {
                    
                }
            }
        }
    }

    trigger OnOpenPage()

    begin
        Rec.SetRange(IsMaster, false);
    end;


}
