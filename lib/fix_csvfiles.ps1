$path = "C:\pvr\giph\GL2019-CSV\TEMP\withholding_tax_expended_payable_temp.csv"
(Get-Content $path -Raw).Replace("`r"," / ") | Set-Content $path -Force
(Get-Content $path -Raw).Replace("`n"," / ") | Set-Content $path -Force
(Get-Content $path -Raw).Replace(" /  / "," // ") | Set-Content $path -Force
(Get-Content $path -Raw).Replace('"Report: " // " //','"Report: "') | Set-Content $path -Force
(Get-Content $path -Raw).Replace('"Report: "  //','Report:') | Set-Content $path -Force
(Get-Content $path -Raw).Replace('For The Period',"`r`nFor The Period") | Set-Content $path -Force
