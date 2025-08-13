# Set the directory path
$directory = "C:\Users\tonol\Desktop\LTEC-GROUP"

# Get all HTML files in the directory and subdirectories
$files = Get-ChildItem -Path $directory -Filter "*.html" -Recurse

# Define the replacement strings
$oldFaviconPath1 = 'href="../assets/img/favicon_png-old-/file/themes-assets/brook/assets_1.0.27/img/favicon.png"'
$oldFaviconPath2 = 'href="../assets/img/favicon-old-/file/themes-assets/brook/assets_1.0.27/img/icon.png"'
$newFaviconPath = 'href="../assets/img/logo.png"'

# Process each file
foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $updatedContent = $content -replace [regex]::Escape($oldFaviconPath1), $newFaviconPath
    $updatedContent = $updatedContent -replace [regex]::Escape($oldFaviconPath2), $newFaviconPath
    
    # Only write back if changes were made
    if ($updatedContent -ne $content) {
        Set-Content -Path $file.FullName -Value $updatedContent -NoNewline
        Write-Host "Updated favicon paths in $($file.FullName)"
    }
}

Write-Host "Favicon update complete!"
