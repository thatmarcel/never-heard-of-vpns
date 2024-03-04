#import <UIKit/UIKit.h>
#import <CFNetwork/CFNetwork.h>

%hookf(CFDictionaryRef, CFNetworkCopySystemProxySettings, void) {
    NSLog(@"NeverHeardOfVPNs CFNetworkCopySystemProxySettings starting");
    CFDictionaryRef ogRef = %orig;

    NSDictionary *og = CFBridgingRelease(ogRef);

    NSLog(@"NeverHeardOfVPNs CFNetworkCopySystemProxySettings from: %@", og);

    NSDictionary *scoped = og[@"__SCOPED__"];

    NSMutableDictionary *newScoped = [scoped mutableCopy];

    NSArray *filters = @[
        @"tap",
        @"tun",
        @"ppp",
        @"ipsec",
        @"ipsec0",
        @"utun1",
        @"utun2"
    ];

    for (NSString *k in scoped.allKeys) {
        if ([filters containsObject: k]) {
            [newScoped removeObjectForKey: k];
        }
    }

    NSMutableDictionary *mutableRes = [NSMutableDictionary new];
    mutableRes[@"FTPPassive"] = @1;
    mutableRes[@"__SCOPED__"] = [newScoped copy];
    mutableRes[@"ExceptionsList"] = [newScoped[@"en0"][@"ExceptionsList"] copy];

    NSDictionary *res = [mutableRes copy];

    NSLog(@"NeverHeardOfVPNs CFNetworkCopySystemProxySettings to: %@", res);

    return (__bridge_retained CFDictionaryRef) res;
}