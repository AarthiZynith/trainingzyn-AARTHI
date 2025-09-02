page 50129 DropDownListPage
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = DropDownTable;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field(ID; rec.ID)
                {
                    ApplicationArea = All;

                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    


}