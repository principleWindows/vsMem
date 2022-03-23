# GPG Signature

- [How to Verify GPG Signature of Downloaded Software on Linux](https://www.linuxbabe.com/security/verify-pgp-signature-software-downloads-linux)
- [How to sign a file on Linux with GPG](https://www.techrepublic.com/article/how-to-sign-a-file-on-linux-with-gpg/)
- [使用.sig签名验证文件](https://www.cnblogs.com/sanduo1314/p/7190065.html)
- [Windows平台GPG签名生成和发布](https://blog.csdn.net/u011174139/article/details/120139497)

********************************

succeed to verify GPG signature
```batch
gpg --verify msys2-x86_64-latest.tar.xz.sig msys2-x86_64-latest.tar.xz
gpg --recv-keys E0AA0F031DBD80FFBA57B06D5A62D0CAB6264964

jicheng@gpuPower:/mnt/d/softwares$ gpg --verify msys2-x86_64-latest.tar.xz.sig msys2-x86_64-latest.tar.xz
gpg: Signature made Sat Mar 19 15:58:05 2022 CST
gpg:                using RSA key E0AA0F031DBD80FFBA57B06D5A62D0CAB6264964
gpg: Good signature from "Christoph Reiter <reiter.christoph@gmail.com>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 0EBF 782C 5D53 F7E5 FB02  A667 46BD 761F 7A49 B0EC
     Subkey fingerprint: E0AA 0F03 1DBD 80FF BA57  B06D 5A62 D0CA B626 4964
jicheng@gpuPower:/mnt/d/softwares$ gpg --recv-keys E0AA0F031DBD80FFBA57B06D5A62D0CAB6264964
gpg: key 46BD761F7A49B0EC: "Christoph Reiter <reiter.christoph@gmail.com>" not changed
gpg: Total number processed: 1
gpg:              unchanged: 1
jicheng@gpuPower:/mnt/d/softwares$ gpg --verify msys2-x86_64-latest.tar.xz.sig msys2-x86_64-latest.tar.xz
gpg: Signature made Sat Mar 19 15:58:05 2022 CST
gpg:                using RSA key E0AA0F031DBD80FFBA57B06D5A62D0CAB6264964
gpg: Good signature from "Christoph Reiter <reiter.christoph@gmail.com>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 0EBF 782C 5D53 F7E5 FB02  A667 46BD 761F 7A49 B0EC
     Subkey fingerprint: E0AA 0F03 1DBD 80FF BA57  B06D 5A62 D0CA B626 4964
```

failed to verify GPG signature
```batch
jicheng@gpuPower:/mnt/d/softwares$ gpg --verify msys2-x86_64-latest.exe.sig msys2-x86_64-latest.tar.xz
gpg: Signature made Sat Jan 29 01:35:32 2022 CST
gpg:                using RSA key E0AA0F031DBD80FFBA57B06D5A62D0CAB6264964
gpg: Can't check signature: No public key
```


