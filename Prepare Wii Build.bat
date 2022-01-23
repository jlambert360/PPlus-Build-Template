del .\Build\Project+\NETPLAY.txt /Q
del .\Build\Project+\NETBOOST.txt /Q
del .\Build\Project+\pf\menu3\dnet.cmnu /Q
rmdir .\Build\Project+\pf\movie /s /q
rmdir .\Build\Project+\pf\sound\netplaylist /s /q
rmdir .\Build\Project+\Source\Netplay /s /q
powershell.exe .\RenameFilesForWiiBuild.ps1
".\Build\Project+\GCTRealMate.exe" -q ".\Build\Project+\RSBE01.txt"
".\Build\Project+\GCTRealMate.exe" -q ".\Build\Project+\BOOST.txt"
powershell.exe .\ZipWiiFiles.ps1
