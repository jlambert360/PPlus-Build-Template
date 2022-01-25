# PPlus Build Template
 Template for people looking to make custom wii/netplay builds

**YOU WILL NEED TO ENABLE POWERSHELL SCRIPTS TO USE THIS! RUN POWERSHELL AS ADMIN AND USE THIS COMMAND:** set-executionpolicy remotesigned

## How to use
 If you want github to build dolphin for you, you need to have a github account. Fork/clone this repository (I reccommend using Github Desktop for managing files).
 
 On your own github page go to the repository settings and enable Actions.
 
 Next put your build files in the Build folder. Everything here will be copied over to the sd.raw when making a netplay build.

## Dolphin 

### Creating/Updating your sd.raw
 To customize the size and where the sd.raw gets made navigate to "MakeSD/Config.ini", open it in a text editor and under SD_CARD_SIZE set the size then under "SD_CARD_PATH" set the path.
 
 Run CreateSD.bat in the root folder to create an sd.raw file or update an existing sd.raw. By default it will be in the "Dolphin/User/Wii" Folder.
 
 Netplay files in the sd.raw will be generated automatically with the exception of "Net-MyMusic.asm", "Net-CodeMenu.asm" and "dnet.cmnu". These files will need to be updated in the NetplayFiles folder with the latest P+ netplay build files. If you have a custom code menu use your custom files instead.
 
### Customizing in game names and controls
 To customize the save file just run P+ offline, set up all the controls the way you want normally, then close the game.
 
 Then copy the files in "User/Wii/title/00010000/52534245/data" to "Sys/Wii/title/00010000/52534245/data".
 
 The files in the User folder will be used for offline play and the files in the Sys folder will be used on netplay.
 
### Building your own dolphin.exe
 Github will build a new dolphin.exe for every change you make in the Dolphin folder as long as you have actions enabled on your repository. 

 If you want to customize the dolphin icon put a custom .ico file in the Resources folder then head to Dolphin/Sys/Resources and customize Dolphin.png, dolphin_logo.png, and dolphin_logo@2x.png.

 After uploading your changes to github, actions will start building your dolphin.exe. Go to your build's github page and click on the actions tab. You should see it start building. After it's done it'll post a release you can download.
 
 Download the zip and put the sd.raw you built with the CreateSD.bat script in the User/Wii folder.
 
## Wii
 Run "Prepare Wii Build.bat" to create a wii build. This will create a .zip file automatically. If you want to disable this edit "Prepare Wii Build.bat" and delete the line that says "powershell.exe .\ZipWiiFiles.ps1"
 
## How to make a custom dolphin updater
 By default github will include an Updater.exe with your dolphin download. If you want to customize where the updater looks for updates follow these steps.
 
 First you need to make the update files. Run the "Delete files (Update).bat" included in the Dolphin folder to remove all files not needed for the update. Then put your sd.raw in the User/Wii folder and zip the files up.
 
 Open ".github/workflows/pr-build.yml" in a text editor and between where it says '- name: "Clone Dolphin"' and '- name: "Build Dolphin"' put this:
 
       - name: "Replace IDs"
        working-directory: ${{ github.workspace }}
        shell: powershell
        run: |
          (Get-Content ${{ github.workspace }}\Ishiiruka\Source\Core\DolphinWX\Main.cpp) -replace 'https://projectplusgame.com/update.json', 'https://raw.githubusercontent.com/jlambert360/jlambert360.github.io/master/BirdBuildTest.json' | Out-File -encoding ASCII ${{ github.workspace }}\Ishiiruka\Source\Core\DolphinWX\Main.cpp

 Replace 'https://raw.githubusercontent.com/jlambert360/jlambert360.github.io/master/BirdBuildTest.json' with a json file that you host somewhere. You can use mine as an example.
 
 To get the hash go here: https://github.com/jlambert360/Ishiiruka/commits/master and hit the 2 squares on the right of the screen on the latest commit to copy the latest hash. You can compare this in dolphin in help->about under Revision.
 
 Version is whatever is displayed after Ishiiruka-Dolphin in the top bar of dolphin.
 
 Changelog is whatever changes you made to your build. You can write whatever you want here.
 
 Download-page-windows/mac is whatever the link to your update files are. I reccommend hosting them on github releases to get a direct link if your build is under 2GB.