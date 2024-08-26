$url = "http://10.0.1.10/"
$numRequests = 50
$concurrentRequests = 2

for ($i = 1; $i -le $numRequests; $i++) {
    Invoke-WebRequest -Uri $url -UseBasicParsing | Out-Null

    if ($i % $concurrentRequests -eq 0) {
        Start-Sleep -Seconds 1
    }
}

Write-Host "Completed $numRequests requests."