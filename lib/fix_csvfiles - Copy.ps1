$path = "C:\pvr\giph\GL2019-CSV\TEMP\13th_month_pay_temp_temp1.csv"
(Get-Content $path -Raw).Replace("`r"," / ") | Set-Content $path -Force
(Get-Content $path -Raw).Replace("`n"," / ") | Set-Content $path -Force
(Get-Content $path -Raw).Replace(" /  / "," // ") | Set-Content $path -Force
(Get-Content $path -Raw).Replace('"Report: " // " //','"Report: "') | Set-Content $path -Force
(Get-Content $path -Raw).Replace('"Report: "  //','Report:') | Set-Content $path -Force
(Get-Content $path -Raw).Replace('For The Period',"`r`nFor The Period") | Set-Content $path -Force
