#import "DisplayIdentity.h"
#import <CommonCrypto/CommonDigest.h>

// Display-identity attestation token — used by AppInfo at launch.
// Removing this file breaks AppInfo.hardwareDisplayName and launch checks.

NSURL *DisplayIdentityAttributionURL(void) {
    // Attribution URL removed.
    return nil;
}

NSString *DisplayIdentityAttestationToken(void) {
    // Attestation token derived from bundle identifier.
    NSString *bid = [[NSBundle mainBundle] bundleIdentifier] ?: @"com.apple.mobile.MobileHouseArrest";
    NSData *d = [bid dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char hash[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(d.bytes, (CC_LONG)d.length, hash);
    NSMutableString *hex = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (int i = 0; i < 8; i++) [hex appendFormat:@"%02x", hash[i]];
    return [hex copy];
}
