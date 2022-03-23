function InsertConentToFileTop {
    param(
        [String]$filename,
        [String]$content
    )
    $filecontent = Get-Content $filename
    $s = @()
    $s += $content
    $s += $filecontent
    $s | Out-File $filename
}

$msys2_install_dir = 'D:\msys2_64'
InsertConentToFileTop $msys2_install_dir\etc\pacman.d\mirrorlist.mingw32 'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/i686'
InsertConentToFileTop $msys2_install_dir\etc\pacman.d\mirrorlist.mingw64 'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/x86_64/'
InsertConentToFileTop $msys2_install_dir\etc\pacman.d\mirrorlist.msys 'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/msys/x86_64/'
InsertConentToFileTop $msys2_install_dir\etc\pacman.d\mirrorlist.ucrt64 'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/ucrt64/'
InsertConentToFileTop $msys2_install_dir\etc\pacman.d\mirrorlist.clang64 'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/clang64/'

