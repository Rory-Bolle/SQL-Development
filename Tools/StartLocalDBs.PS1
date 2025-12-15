# PowerShell script to start SQL Server (default instance) and SQL Server Agent

$services = @("MSSQLSERVER", "SQLSERVERAGENT")

foreach ($service in $services) {
    try {
        $svc = Get-Service -Name $service -ErrorAction Stop
        
        if ($svc.Status -eq "Running") {
            Write-Host "$($svc.DisplayName) is already running." -ForegroundColor Green
        }
        elseif ($svc.Status -eq "Stopped") {
            Write-Host "Starting $($svc.DisplayName)..." -ForegroundColor Yellow
            Start-Service -Name $service -ErrorAction Stop
            Write-Host "$($svc.DisplayName) started successfully." -ForegroundColor Green
        }
        else {
            Write-Host "$($svc.DisplayName) is in state: $($svc.Status). Attempting to start..." -ForegroundColor Yellow
            Start-Service -Name $service -ErrorAction Stop
            Write-Host "$($svc.DisplayName) started." -ForegroundColor Green
        }
    }
    catch {
        Write-Error "Failed to interact with $service. Error: $($_.Exception.Message)"
    }
}

Write-Host "Script completed." -ForegroundColor Cyan