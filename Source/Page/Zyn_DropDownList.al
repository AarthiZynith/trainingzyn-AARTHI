page 50129 Zyn_DropDownList
{
    Caption='DropDownList';
    PageType = List;
    ApplicationArea = All;
    SourceTable = Zyn_DropDownTable;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field(ID; rec.ID)
                {
                
                }
                field(Name; Rec.Name)
                {

                }
            }
        }
    }



}