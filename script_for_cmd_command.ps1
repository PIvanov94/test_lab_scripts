# Define the list of server names or IP addresses
$serverList = @("Server1", "Server2", "Server3")

# Define the command to run on each server
$commandToRun = "echo Hello, World!"

# Define the string to compare the command output to
$expectedOutput = "Hello, World!"

# Create an array to store the results for each server
$results = @()

# Loop through the list of servers
foreach ($server in $serverList) {
    Write-Host "Connecting to $server..."
    
    try {
        # Use PowerShell Remoting to log in to the remote server
        $session = New-PSSession -ComputerName $server -Credential (Get-Credential)
        
        # Run the command on the remote server and capture the output
        $output = Invoke-Command -Session $session -ScriptBlock { param($cmd) & cmd.exe /c $cmd } -ArgumentList $commandToRun
        
        # Close the remote session
        Remove-PSSession $session
        
        # Compare the output to the expected string
        if ($output -eq $expectedOutput) {
            $result = "Match: $server - Output: $output"
        } else {
            $result = "No Match: $server - Output: $output"
        }
    } catch {
        $result = "Error connecting to $server: $_"
    }
    
    # Add the result to the array
    $results += $result
}

# Display the results for all servers
$results | ForEach-Object { Write-Host $_ }
