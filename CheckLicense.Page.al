Page 50124 "Check License"
{
    PageType = Card;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Filter Object Exists";ExistFilter)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CurrPage.LicencePage.Page.SetExistFilter(ExistFilter);
                    end;
                }
                group(Control1000000007)
                {
                    field("LicenseInfo1.Text";LicenseInfo1.Text)
                    {
                        ApplicationArea = Basic;
                    }
                    field("LicenseInfo2.Text";LicenseInfo2.Text)
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
            part(LicencePage;"Check License Perm. Subform")
            {
                Caption = 'Object Permissions';
            }
            part(VersionPage;"Check License Version Subform")
            {
                Caption = 'Object Versions';
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        CurrPage.VersionPage.Page.ClearTmpRec;

        LicenseInfo1.Get(4);
        LicenseInfo2.Get(5);

        PopulateVersionList;

        VersionTextBuffer2.Reset;
        if VersionTextBuffer2.Find('-') then
          repeat
            CurrPage.VersionPage.Page.SetTMPRec(VersionTextBuffer2);
          until VersionTextBuffer2.Next = 0;
        CurrPage.VersionPage.Page.UpdatePage;
    end;

    var
        ">>License": Integer;
        LicenseInfo1: Record "License Information";
        LicenseInfo2: Record "License Information";
        ExistFilter: Boolean;
        ">>Version": Integer;
        VersionTextBuffer: Record "Excel Buffer" temporary;
        VersionTextBuffer2: Record "Excel Buffer" temporary;


    procedure PopulateVersionList()
    var
        "Object": Record "Object";
        IntPos: Integer;
        BaseVersion: Text[250];
        VersionText: Text[250];
        i: Integer;
    begin
        VersionTextBuffer.Reset;
        VersionTextBuffer.DeleteAll;

        i := 0;
        Object.Reset;
        Object.SetCurrentkey(Type,Name);
        Object.SetFilter("Version List",'<>%1','');
        if Object.Find('-') then
          repeat
            while StrPos(Object."Version List",',') <> 0 do begin
              i := i + 1;
              VersionText := CopyStr(Object."Version List",1,StrPos(Object."Version List",',')-1);
              Object."Version List" := CopyStr(Object."Version List",StrPos(Object."Version List",',')+1,StrLen(Object."Version List"));
              InsertVersionBuffer(VersionText,i);
            end;
            i := i + 1;
            VersionText := Object."Version List";
            InsertVersionBuffer(VersionText,i);
          until Object.Next = 0;

        i := 0;
        VersionTextBuffer.Reset;
        if VersionTextBuffer.Find('-') then
          repeat
            i := i + 1;
            IntPos := FindFirstNo(VersionTextBuffer."Cell Value as Text");
            if IntPos > 0 then begin
              BaseVersion := CopyStr(VersionTextBuffer."Cell Value as Text",1,IntPos-1);
              CutVersion(VersionText,IntPos,BaseVersion);
              InsertVersionBuffer2(VersionText,BaseVersion,i);
            end;
          until VersionTextBuffer.Next = 0;
    end;


    procedure InsertVersionBuffer(VersionText: Text[250];i: Integer)
    begin
        VersionTextBuffer.SetRange("Cell Value as Text",VersionText);
        if VersionTextBuffer.IsEmpty then begin
          VersionTextBuffer.SetRange("Cell Value as Text");

          VersionTextBuffer."Row No." := i;
          VersionTextBuffer."Cell Value as Text" := VersionText;
          VersionTextBuffer.Insert;
        end;
    end;


    procedure InsertVersionBuffer2(NewVersion: Text[250];BaseVersion: Text[250];i: Integer)
    var
        HighestVersion: Text[250];
        VersionInt: Text[250];
    begin
        HighestVersion := '';

        VersionTextBuffer2.SetRange("Cell Value as Text",BaseVersion);
        if VersionTextBuffer2.Find('-') then begin
          repeat
          if HighestVersion < VersionTextBuffer2.Comment then
            HighestVersion := VersionTextBuffer2.Comment;
          until VersionTextBuffer2.Next = 0;
          if NewVersion > HighestVersion then begin
            VersionTextBuffer2.Comment := NewVersion;
            VersionTextBuffer2.Formula := VersionTextBuffer."Cell Value as Text";
            VersionTextBuffer2.Modify;
          end;
        end else begin
          VersionTextBuffer2."Row No." := i;
          VersionTextBuffer2."Cell Value as Text" := BaseVersion;
          VersionTextBuffer2.Comment := NewVersion;
          VersionTextBuffer2.Formula := VersionTextBuffer."Cell Value as Text";
          VersionTextBuffer2.Insert;
        end;
    end;


    procedure FindFirstNo(TextVar: Text[250]): Integer
    var
        TextInt: Integer;
        i: Integer;
    begin
        for i := 1 to StrLen(TextVar) do begin
          if Evaluate(TextInt,CopyStr(TextVar,i,1)) then
            exit(i);
        end;
    end;


    procedure CutVersion(var VersionText: Text[250];IntPos: Integer;BaseVersion: Text[250])
    begin
        // Add baseversions in this function when needed
        case true of
          BaseVersion in ['PM','PMBS']:
            VersionText := CopyStr(VersionTextBuffer."Cell Value as Text",
              11,StrLen(VersionTextBuffer."Cell Value as Text"));
          BaseVersion = 'DKLL':
            VersionText := CopyStr(VersionTextBuffer."Cell Value as Text",
              10,StrLen(VersionTextBuffer."Cell Value as Text"));
          else
            VersionText := CopyStr(VersionTextBuffer."Cell Value as Text",
              IntPos,StrLen(VersionTextBuffer."Cell Value as Text"));
        end;
    end;
}

