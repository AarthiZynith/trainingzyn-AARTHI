page 50103 Zyn_IndexSubpage
{
    Caption = 'IndexSubpage';
    PageType = ListPart;
    SourceTable = Zyn_IndexSubpage;
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(group)
            {

                field(Year; Rec.Year)
                {

                }
                field(value; Rec.value)
                {

                }
            }
        }
    }
}