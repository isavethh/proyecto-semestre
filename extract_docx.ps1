param($docxPath, $outputPath)

Add-Type -AssemblyName System.IO.Compression.FileSystem

$zip = [System.IO.Compression.ZipFile]::OpenRead($docxPath)
$entry = $zip.Entries | Where-Object { $_.FullNamee -eq "word/document.xml" }

if ($entry) {
    $stream = $entry.Open()
    $reader = New-Object System.IO.StreamReader($stream)
    $content = $reader.ReadToEnd()
    $reader.Close()
    $stream.Close()
    
    # Remove XML tags and clean up
    $text = $content -replace '<[^>]+>', ' '
    $text = $text -replace '\s+', ' '
    $text.Trim() | Out-File $outputPath -Encoding UTF8
}

$zip.Dispose()
