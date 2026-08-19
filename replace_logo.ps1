$htmlFiles = Get-ChildItem -Filter *.html
foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    $nc = [regex]::Replace($content, '(?is)<a[^>]*class="header-logo"[^>]*>.*?</a>', '<a href="index.html" class="header-logo"><img src="images/new_logo.png" alt="Divine Dental Centre" class="img-fluid"></a>')
    $nc = [regex]::Replace($nc, '(?is)<div class="footer-logo">\s*<img[^>]*>\s*</div>', '<div class="footer-logo"><img src="images/new_logo.png" alt="Divine Dental Centre" class="img-fluid"></div>')
    $nc = $nc -replace 'images/new\.png', 'images/new_logo.png' -replace 'images/logo\.png', 'images/new_logo.png' -replace 'images/footer-logo\.png', 'images/new_logo.png'
    
    if ($content -ne $nc) {
        Set-Content -Path $file.FullName -Value $nc -Encoding UTF8
        Write-Host "Updated $($file.Name)"
    }
}
