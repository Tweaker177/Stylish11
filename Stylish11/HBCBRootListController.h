#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListController.h>
#import <CepheiPrefs/HBRootListController.h>
#import <UIKit/UIKit.h>

/** these used in StackXI, tried that method but didn't work on iOS 10 device compiler

#import <Cephei/HBPreferences.h>

#import <CepheiPrefs/HBAppearanceSettings.h>
**/


@interface HBCBRootListController : HBRootListController

-(void)respring:(id)sender;
- (void)donate;
-(void)save; //not sure the use of this
@end


/** tried category and different interface-neither worked

@interface HBRootListController : UIViewController
@end


@interface HBListController (new)
-(void)viewWillAppear:(BOOL)animated;
-(void)viewDidAppear:(BOOL)animated;
@end

@implementation HBListController (new)
-(void)viewWillAppear:(BOOL)animated
{


	[self reload];// old call but left just in case
if([self.view viewWillAppear:animated]) {

	[superview viewWillAppear:animated];
}
	[superview viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{

	[superview viewDidAppear:animated];
}
@end
**/
