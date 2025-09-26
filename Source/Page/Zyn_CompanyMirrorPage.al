page 50242 "Zyn_CompanyMirrorList"
{
    Caption = 'Company Mirror';
    PageType = List;
    SourceTable = Zyn_Company;
    ApplicationArea = All;
    UsageCategory = Lists; // shows in search (Tell Me)

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
                field("Evaluation Company"; Rec."Evaluation Company")
                {

                }
                field(Id; Rec.Id)
                {

                }
                field("Business Profile Id"; Rec."Business Profile Id")
                {

                }
                field(IsMaster;Rec.IsMaster)
                {

                }
                field(MasterCompanyName;Rec.MasterCompanyName)
                {
                    
                }
            }
        }
    }

}
