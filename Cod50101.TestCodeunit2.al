codeunit 50101 TestCodeunit2
{
    var
        TestCodeunit: Codeunit TestCodeunit;
        TestTable: Record TestTable;
        IntCount: Integer;

    Trigger OnRun()
    VAr
    Begin
        IntCount += 1;
        IF TestCodeunit.RUN THEN begin
        End ELSE BEGIN
            TestTable.RESET;
            If TestTable.GET(3) THEN BEGIN
                TestTable.Description += FORMAT(IntCount);
                TestTable.Modify;
                Commit;
                TestTable.Findset;
                //TaskScheduler.CreateTask(Codeunit::TestCodeunit, Codeunit::TestCodeunit2, True, CompanyName, CurrentDateTime, TestTable.RecordID);
            End;
        END;
    End;

}
