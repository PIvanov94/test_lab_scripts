# Define the path to the Notepad file containing VM names, one per line
$notepadFilePath = "C:\Path\to\VMList.txt"

# Check if the file exists
if (Test-Path $notepadFilePath) {
    # Read VM names from the file
    $vmNames = Get-Content $notepadFilePath

    # Connect to your Citrix XenServer host
    Connect-XenServer -ServerName YourXenServerHost -UserName YourUserName -Password YourPassword

    # Loop through each VM name and reboot the corresponding VM
    foreach ($vmName in $vmNames) {
        $vm = Get-XenVM -Name $vmName
        if ($vm -ne $null) {
            Write-Host "Rebooting VM: $vmName"
            Restart-XenVM -VM $vm -Force
        } else {
            Write-Host "VM not found: $vmName"
        }
    }

    # Disconnect from the XenServer host
    Disconnect-XenServer
} else {
    Write-Host "File not found: $notepadFilePath"
}
