
#CREATING/CHANGE DIRECTORY
md -Force C:\tim_pshell

cd c:\tim_pshell

#FUNCTIONS
function Get-Snapshot1 {
$a = get-process | select id, processname, Path
$a | export-csv first_snapshot.csv
write-host "First Snapshot: C:\tim_pshell\first_snapshot.csv"
}

function Get-Snapshot2 {
write-host "Excel Startup Complete. Now proceeding to second snapshot"
$b = get-process | select id, processname, Path
$b | export-csv second_snapshot.csv
write-host "Second Snapshot: C:\tim_pshell\second_snapshot.csv"
}

function Get-Comparison {
$objects = @{
ReferenceObject = (Get-Content -Path C:\tim_pshell\first_snapshot.csv)
DifferenceObject = (Get-Content -Path C:\tim_pshell\second_snapshot.csv)
}
$Results = Compare-Object @objects
$Results | Export-Csv snapshot_comparison.csv | Format-Table
}

function View-comparison {
$a = Import-Csv .\snapshot_comparison.csv
$a | Out-File -FilePath C:\tim_pshell\analysis.txt
}

function destroy-evidence {
remove-item .\first_snapshot.csv
remove-item .\second_snapshot.csv
remove-item .\snapshot_comparison.csv
}


#STUFF TO RUN
Get-Snapshot1

Start-Process Notepad
Start-Sleep -S 1

Get-Snapshot2

Start-sleep -S 2

Get-Comparison

Start-sleep -S 2

Stop-Process -name Notepad

Start-sleep -s 1

View-comparison

destroy-evidence

Write-Host "Check C:\tim_pshell for Analysis.txt!" -ForegroundColor Green -BackgroundColor Gray