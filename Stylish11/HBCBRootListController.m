
#import "HBCBRootListController.h"
#import "UIColor+randomPrefs.h"
#include <CSColorPicker/CSColorPicker.h>


@implementation UIColor (randomPrefs)

+(UIColor *) myRedRand {
int b = 180 - (arc4random_uniform(150));
int g = 90 - arc4random_uniform(75);
int r = 255- arc4random_uniform(55);
return [UIColor colorWithRed: (r/255.0) green: (g/255.0) blue: (b/255.0) alpha:1.0 ];
}
@end

@implementation HBCBRootListController
/**
- (instancetype)init {
    self = [super init];

    if (self) {
        HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
        appearanceSettings.tintColor = [UIColor myRedRand];
        appearanceSettings.tableViewCellSeparatorColor = [UIColor colorWithWhite:0 alpha:0.2];
        self.hb_appearanceSettings = appearanceSettings;
    }

    return self;
}

- (id)specifiers {
    if(_specifiers == nil) {
        _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
    }
    return _specifiers;
}
**/
/**
-(void)viewWillAppear:(BOOL)animated
{


	[self reload]; 

	[super viewWillAppear:animated];

}
**/
/*
-(void)viewDidAppear:(BOOL)animated
{

	[super viewDidAppear:animated];
}
*/

/** from StackXI Github, trying to get viewWillAppear and DidAppear to work (no luck), left this portion out when I tried

    CGRect frame = self.table.bounds;
    frame.origin.y = -frame.size.height;

    [self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
    self.navigationController.navigationController.navigationBar.translucent = YES;
}
**/

/**
-(void)viewWillAppear:(BOOL)animated
{

//necessary for picked colors to update immediately but has compile error
	 [self reload]; //old call but left just in case

	[super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
 

	[super viewDidAppear:animated];
}
****/



+ (UIColor *)hb_tintColor {
	return [UIColor myRedRand];
}

#pragma mark - Constants

+ (NSString *)hb_shareText {
	NSString *sharestylish = @"I'm using  #Stylish11 #Cydiatweak by i0s_tweak3r. Awesome new update available now: Hosted by @yourepo .";
	return sharestylish;
}

+ (NSURL *)hb_shareURL {
	return [NSURL URLWithString:@"http://i0s-tweak3r-betas.yourepo.com/pack/stylish11"];
}

+ (NSString *)hb_specifierPlist {
	return @"Root";
}


- (void)save
{
    [self.view endEditing:YES];
}

-(void)respring{
  system("killall -9 SpringBoard");
}
- (void)donate
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/i0stweak3r"]];
}
@end


