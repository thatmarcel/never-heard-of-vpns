# NeverHeardOfVPNs
**Jailbreak tweak to bypass local VPN checks in iOS applications**

## Building
You need to have [Theos](https://theos.dev/docs/installation) installed.

### Rootless
To build this tweak for iOS devices on rootless jailbreaks, run the following command:
```
make package FINALPACKAGE=1 THEOS_PACKAGE_SCHEME=rootless
```

### Rootful
To build this tweak for iOS devices on rootful jailbreaks, run the following command:
```
make package FINALPACKAGE=1
```