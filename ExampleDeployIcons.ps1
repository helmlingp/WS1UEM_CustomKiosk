<#	
    .Synopsis
      This powershell script copies icon files.
    .NOTES
	  Created:   	August, 2020
	  Created by:	Phil Helmling, @philhelmling
	  Organization: VMware, Inc.
	  Filename:     Deploy_Icons.ps1
	.DESCRIPTION
	  This powershell script copies icon files
	  
    .EXAMPLE
      powershell.exe -ep bypass -file .\Deploy_Shortcuts.ps1
#>
$current_path = $PSScriptRoot;
if($PSScriptRoot -eq ""){
    #PSScriptRoot only popuates if the script is being run.  Default to default location if empty
    $current_path = "C:\Temp";
}

#$buildfilespath = "C:\BuildFiles"
$KIOSKpath = $env:PROGRAMFILES"\CUSTOMER"

#If(!(test-path $buildfilespath)){
#	New-Item -ItemType Directory -Force -Path $buildfilespath
#}

If(!(test-path $WWpath)){
	New-Item -ItemType Directory -Force -Path $WWpath
}

#Copy-Item -Path "$current_path\Icons" -Destination $buildfilespath -Force -Recurse
Copy-Item -Path "$current_path\Icons" -Destination $KIOSKpath -Force -Recurse
#Copy-Item -Path "$current_path\Icons\*.ico" -Destination "C:\Windows\" -Force

#set ACL on folder to allow Kiosk Users to see the Icons
#Get-Acl $env:ALLUSERSPROFILE"\Microsoft\Windows\Start Menu\Programs" | Set-Acl $env:PROGRAMFILES"\CUSTOMER"
