del "..\Build\Project+\NETPLAY.txt" -Confirm:$false -Recurse -erroraction 'silentlycontinue'
del "..\Build\Project+\NETBOOST.txt" -Confirm:$false -Recurse -erroraction 'silentlycontinue'
del "..\Build\Project+\pf\menu3\dnet.cmnu" -Confirm:$false -Recurse -erroraction 'silentlycontinue'
del "..\Build\Project+\pf\movie" -Confirm:$false -Recurse -erroraction 'silentlycontinue'
del "..\Build\Project+\pf\sound\netplaylist" -Confirm:$false -Recurse -erroraction 'silentlycontinue'
del "..\Build\Project+\Source\Netplay" -Confirm:$false -Recurse -erroraction 'silentlycontinue'
del "..\Build\Project+\pf\toy\seal" -Confirm:$false -Recurse -erroraction 'silentlycontinue'

#RSBE01.txt
$rsbe01Path = "..\Build\Project+\RSBE01.txt"
$strapcode = Select-String -Path $rsbe01Path -Pattern "046CADE8"
if ($strapcode -ne $null)
{
	(Type "..\Build\Project+\RSBE01.txt") -notmatch "^* 046CADE8 48000298$" | Set-Content "..\Build\Project+\RSBE01.txt"
}