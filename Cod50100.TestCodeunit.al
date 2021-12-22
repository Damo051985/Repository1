codeunit 50100 TestCodeunit
{
    trigger OnRun()
    Var
        lTestTable: Record "TestTable";
        lEntryNo: Integer;
    begin
        IF lTestTable.FINDLAST THEN
            lEntryNo := lTestTable.EntryNO
        else
            lEntryNo := 1;

        lTestTable.RESET;
        IF lTestTable.GET(3) then begin
            IF lTestTable.NAme = 'eeee' THEN
                Error('Test');
        End;
    end;

}
