#import "HBCBAboutListController.h"
#import "PSHeaderFooterView.h"
#import "UIColor+randomPrefs.h"

@implementation UIColor (randomPrefs)

+(UIColor *) myRedRand {
int b = 180 - (arc4random_uniform(150));
int g = 90 - arc4random_uniform(75);
int r = 255- arc4random_uniform(55);
return [UIColor colorWithRed: (r/255.0) green: (g/255.0) blue: (b/255.0) alpha:1.0 ];
}
@end

@implementation HBCBAboutListController
+ (UIColor *)hb_tintColor {
	return [UIColor myRedRand];
}
#pragma mark - Constants


+ (NSString *)hb_shareText {
	NSString *sharestylish = @"I'm using #StylishCydiaPackage by i0s_tweak3r, updated for iOS 11, and packed with new features.  #Stylish11";
	return sharestylish;
}

+ (NSURL *)hb_shareURL {
	return [NSURL URLWithString:@"http://moreinfo.thebigboss.org/moreinfo/depiction.php?file=stylish11Dp"];
}


+ ( NSString *)hb_supportEmailAddress {
NSString *addy = @"djvs23@gmail.com"; return addy;
}




+ (NSString *)hb_specifierPlist {
	return @"About";
}



@end