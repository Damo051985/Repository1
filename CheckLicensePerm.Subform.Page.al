Page 50125 "Check License Perm. Subform"
{
    Caption = 'Check License Perm. Subform';
    PageType = CardPart;
    SourceTable = "License Permission";
    SourceTableView = sorting("Object Type","Object Number")
                      where("Object Type"=filter(Table..Query));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'License';
                field("Object Type";"Object Type")
                {
                    ApplicationArea = Basic;
                }
                field("Object Number";"Object Number")
                {
                    ApplicationArea = Basic;
                }
                field("Read Permission";"Read Permission")
                {
                    ApplicationArea = Basic;
                }
                field("Insert Permission";"Insert Permission")
                {
                    ApplicationArea = Basic;
                }
                field("Modify Permission";"Modify Permission")
                {
                    ApplicationArea = Basic;
                }
                field("Delete Permission";"Delete Permission")
                {
                    ApplicationArea = Basic;
                }
                field("Execute Permission";"Execute Permission")
                {
                    ApplicationArea = Basic;
                }
                field(ObjExist;ObjExist)
                {
                    ApplicationArea = Basic;
                    Caption = 'Object Exists';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ObjExist := Obj.Get("Object Type",COMPANYNAME,"Object Number");
        if not ObjExist then
          ObjExist := Obj.Get("Object Type",'',"Object Number");

        if ObjExistFilter and ObjExist then
          Mark;
    end;

    trigger OnOpenPage()
    begin
        // RESET;
        SetFilter("Object Number",'%1..%2',50000,99999);
        ClearMarks;

        if ObjExistFilter then
          MarkedOnly(true);
    end;

    var
        Obj: Record "Object";
        ObjExist: Boolean;
        ObjExistFilter: Boolean;


    procedure SetExistFilter(SetFilter: Boolean)
    begin
        ObjExistFilter := SetFilter;

        MarkedOnly(false);
        ClearMarks;
        if ObjExistFilter then begin
          Obj.Reset;
          if Obj.Find('-') then
            repeat
              Get(Obj.Type,Obj.ID);
              Mark(true);
            until Obj.Next = 0;
            MarkedOnly(true);
        end;

        CurrPage.Update(false);
    end;
}

