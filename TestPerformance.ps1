$repeat = 25000

function Test-Array {
    $time1 = Measure-Command {
        $array = @()
        (1..$repeat).ForEach({ $array += $_ })
    }
    
    $time2 = Measure-Command {
        $arrayList = [System.Collections.ArrayList]::new()
        (1..$repeat).ForEach({ $arrayList += $_ })
    }
    
    "Array:     $($time1.TotalMilliseconds) ms"
    "ArrayList: $($time2.TotalMilliseconds) ms" # faster way
}

function Test-AddWay {
    $time1 = Measure-Command {
        $arrayList = [System.Collections.ArrayList]::new()
        (1..$repeat).ForEach({ $arrayList += $_ })
    }
    
    $time2 = Measure-Command {
        $arrayList = [System.Collections.ArrayList]::new()
        (1..$repeat).ForEach({ $arrayList.Add($_) })
    }

    $time3 = Measure-Command {
        $arrayList = [System.Collections.ArrayList]::new()
        $arrayList.AddRange(1..$repeat)
    }
    
    "'+=' operator:     $($time1.TotalMilliseconds) ms"
    "'Add' method:      $($time2.TotalMilliseconds) ms" # faster way
    "'AddRange' method: $($time3.TotalMilliseconds) ms" # fastest way
}

function Test-RemoveReturnValue {
    $time1 = Measure-Command {
        $arrayList = [System.Collections.ArrayList]::new()
        (1..$repeat).ForEach({ $arrayList.Add($i) | Out-Null })
    }
    
    $time2 = Measure-Command {
        $arrayList = [System.Collections.ArrayList]::new()
        (1..$repeat).ForEach({ [void]$arrayList.Add($i) })
    }
    
    $time3 = Measure-Command {
        $arrayList = [System.Collections.ArrayList]::new()
        (1..$repeat).ForEach({ [void]$arrayList.Add($i) })
    }
    
    "'Out-Null' cmdlet: $($time1.TotalMilliseconds) ms"
    "'void' type:       $($time2.TotalMilliseconds) ms" # faster way
    "'`$null' value:     $($time3.TotalMilliseconds) ms" # faster way
}

function Test-RegexReplace {
    $name = "MyName"
    $message = ("This is a sample with {{name}} placeholder.`n" * $repeat)

    $time1 = Measure-Command {
        [void]$message -replace "{{name}}", $name
    }
    
    $time2 = Measure-Command {
        [void]$message.Replace("{{name}}", $name)
    }

    "PowerShell -replace:   $($time1.TotalMilliseconds) ms" # faster way
    "System.String.Replace: $($time2.TotalMilliseconds) ms"
}

function Test-String {
    $time1 = Measure-Command {
        $result = ""
        foreach ($num in (1..$repeat)) {
            $result += "$num "
        }
    }
    
    $time2 = Measure-Command {
        $resultSb = [System.Text.StringBuilder]::new()
        foreach ($num in (1..$repeat)) {
            [void]$resultSb.Append("$num ")
        }
    }

    "'+=' operator:             $($time1.TotalMilliseconds) ms"
    "System.Text.StringBuilder: $($time2.TotalMilliseconds) ms" # faster way
}

function Test-FileNameWithoutExtension {
    $path = $PSCommandPath
    
    $time1 = Measure-Command {
        foreach ($i in (1..$repeat)) {
            $null = (Split-Path -Leaf $path) -replace '\.ps1$', ''
        }
    }
    
    $time2 = Measure-Command {
        foreach ($i in (1..$repeat)) {
            $null = [System.IO.Path]::GetFileNameWithoutExtension($path)
        }
    }
    
    "Split-Path + -replace:                         $($time1.TotalMilliseconds) ms"
    "[System.IO.Path]::GetFileNameWithoutExtension: $($time2.TotalMilliseconds) ms" # faster way
}
