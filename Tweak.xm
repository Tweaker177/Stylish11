#include <stdlib.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <CSColorPicker/CSColorPicker.h>


#define PLIST_PATH                                                                                                                  \
@"/var/mobile/Library/Preferences/com.i0stweak3r.stylish11.plist"


static double dockpercent = 0.f;
static double dockheightfrac = dockpercent/100;

//random r-g-b values

double r1 = arc4random_uniform(255);
double g1 = arc4random_uniform(255);
double b1 = arc4random_uniform(255);
static double cpiR=r1;
static double cpiG=g1;
static double cpiB=b1;
static double piR=1-(cpiR/255);
static double piG=1-(cpiG/255);
static double piB=1-(cpiB/255);

static UIColor *randocol;
static UIColor *rando[260];
static double Opacityval = 80.0;
static double trans = Opacityval/100;
static double highlightlevel = 50.0;
static double highlightAlph = highlightlevel/100;
static bool wantsSpotlight= YES;
static int colorInt = 1;
static bool kWantsTranslucentFolders = YES;
static bool kWantsNoLabels = YES;
static bool kHideAllButLabels = YES; //key35
static bool kNoJitters = YES;  //key12
static bool kSlidersEnabled = YES;
static bool kSquareUI = YES; //isSquareCC
static bool kRoundUI= YES; //isCircularCC
static bool kHideDotsAndX = YES; //key6
static bool kScreenshotsDisabled = NO;
 //key23
static bool kSquareIcons = YES; //key11
static bool kCircularFolders = YES; //key17
static bool kWantsRandomHighlights = YES;
//key3
static bool kWantsClearHighlights = YES; //key1
static bool kBlackText = YES; //key2
//key2= CustomIconColor, not black anymore
static NSString *kIconHex = @"FFFFFF";

static bool kRandomText = YES; //key22
static bool kBlackLabel = YES; //key16
//BlackLabel is now custom color
static bool kRandomLabel = YES; //key15

static bool kHideBadges = YES; //key4
static bool kRandomLS = YES; //key13
static bool kBlackLS = YES; //key14
//BlackLS is now custom color
static bool kHidePageDots = YES; //key9
static bool kHideScreenFlash = YES; //key25
static bool kRandomPageDots = YES; //key10
static NSString *kLockscreenHex = @"FFFFFF";

static NSString *kDockColorHex = @"FFFFFF";
static bool kDockColorEnabled = NO;
static CGFloat colorTrans;
static bool kCustomColorHighlights = YES;
static NSString *kCustomHighlightHex = @"FFFFFF";
static UIColor *customHighlightColor = [[UIColor colorFromHexString:kCustomHighlightHex] colorWithAlphaComponent:highlightAlph];
static bool kFolderColorEnabled = YES;
static bool kOpenFolderColorEnabled = YES;


static UIColor *screenColor;
static double kCCContinuousControl;
static double kCCCornerRadius;

@interface UIColor (myColors)
+(UIColor *)randomSpot;
@end

@interface SBFloatyFolderBackgroundClipView : UIView
@end

@interface SBFolderIconBackgroundView : UIView
@end

@interface SBFolderIconImageView : UIView
@end


@interface SBDockView : UIView
@end

@interface SBFolderBackgroundView : UIView
@end

@implementation UIColor(myColors) 
+(UIColor *)randomSpot {
int randomInt =  arc4random_uniform(12);
switch (randomInt) {
case 0: return [UIColor redColor];
break;
case 1: return [UIColor blueColor];
break;
case 2: return [UIColor yellowColor];
break;
case 3: return [UIColor magentaColor];
break;
case 4: return [UIColor greenColor];
break;
case 5: return [UIColor orangeColor];
break;
case 6: return [UIColor purpleColor];
break;
case 7: return [UIColor blueColor];
break;
case 8: return [UIColor darkGrayColor];
break;
case 9: return [UIColor purpleColor];
break;
case 10: return [UIColor cyanColor];
break;
case 11: return [UIColor brownColor];
break;
default: return [UIColor whiteColor];
break;
}
}
@end


%hook SPUITextField
 -(void)updateWithColor:(UIColor *)tintColor {

if(wantsSpotlight)
{

UIColor *actualColor;

switch (colorInt) 
{
case 0: actualColor= [UIColor randomSpot];
break;
case 1: actualColor= [UIColor redColor];
break;
case 2: actualColor= [UIColor greenColor];
break;
case 3: actualColor= [UIColor orangeColor];
break;
default: actualColor= [UIColor whiteColor];
break;
}

tintColor = actualColor;
return %orig(tintColor);
}
return %orig;
}

%end


%hook SBIconColorSettings
-(bool) blurryFolderIcons {
if(kWantsTranslucentFolders) {
return FALSE;

}
return %orig;
}

-(double) colorAlpha {
if(kWantsTranslucentFolders) {
return 0.1;
}
return %orig;
}

-(double) whiteAlpha {
if(kWantsTranslucentFolders) {
return 0.1;

}
return %orig;
}
%end

%hook SBFWallpaperSettings
-(bool) replaceBlurs {
if(kWantsTranslucentFolders) {
return TRUE;
}
return %orig;
}
%end

%hook SBIconView
-(void) setIconLabelAlpha:(double)arg1 {
if(kWantsNoLabels) {
arg1= 0; //hide labels

return %orig(arg1);
}
arg1= 1.f;
return %orig;
}
%end

//transparent labels

%hook SBIconView
-(void) setAllIconElementsButLabelToHidden:(bool)arg1 {
if(kHideAllButLabels) {
arg1=TRUE;
return %orig;
}
return %orig;
}
//Hide everything but labels on icons

-(void) _applyIconImageAlpha:(double)arg1 {
if(kHideAllButLabels) {
arg1=0;
return %orig;
}
return %orig;
}

//Hide All But Labels

-(void) setIconImageAndAccessoryAlpha:(double)arg1 {
if(kHideAllButLabels) {
arg1=0;
return %orig(arg1);
}
return %orig;
}
%end
//Set alpha to zero to hide icons n folders


%hook SBIconView
-(void) setLabelAccessoryViewHidden:(bool)arg1 {
if(kHideAllButLabels) {
arg1=TRUE;
return %orig;
}
return %orig;
} 


-(void) setIconAccessoryAlpha:(double)arg1 {
if((kHideAllButLabels) || (kHideDotsAndX)) {
arg1=0;
return %orig;
}
return %orig;
}
//Hide Accessory View(dots)


-(void) _applyIconAccessoryAlpha:(double)arg1 {
if((kHideAllButLabels) || (kHideDotsAndX)) {
arg1=0;
return %orig;
}
return %orig; 
}


+(bool) canShowLabelAccessoryView {
if((kHideAllButLabels) || (kHideDotsAndX)) {
return FALSE;
}
return %orig;
}
//hide tiny icon dots and X's to delete

%end

%hook SBIconImageView
+(double)cornerRadius {
if(kCircularFolders) {
return 28.5f;
}
else 
if(kSquareIcons) {
return 0.f;
}
else {
return %orig; }
}

-(BOOL)showsSquareCorners{
if(kSquareIcons) {
return TRUE;
} 
return %orig; 
}

-(void)setShowsSquareCorners:(BOOL)arg1 {
if(kSquareIcons) {
arg1=TRUE;
return %orig(arg1);
}
return %orig; 
}
%end

%hook SBIconColorSettings
-(bool)suppressJitter {
if(kNoJitters) {
return TRUE;
}
return %orig;
}

-(void)setSupressJitter:(bool)arg1{
if(kNoJitters) {
arg1=TRUE;
return %orig;
}
return %orig;
}
%end

%hook SBIconView
-(void) setAllowsJitter:(bool)arg1 {
if(kNoJitters) {
arg1=FALSE;
return %orig;
}
return %orig;
}
-(void) setAllowJitter:(bool)arg1 {
if(kNoJitters) {
arg1=FALSE;
return %orig;
}
return %orig;
}

-(bool)allowsJitter {
if(kNoJitters) {
return FALSE;
}
return %orig;
}
%end

%hook SBIconImageView
-(BOOL)isJittering {
if(kNoJitters) {
return FALSE;
}
return %orig;
}

-(void)setJittering:(BOOL)arg1 {
if(kNoJitters) {
arg1=FALSE;
return %orig;
}
return %orig;
}
%end
/********* NEW *******/
%hook SBFolderBackgroundView
-(void)layoutSubviews {
if((kFolderColorEnabled)&&(kOpenFolderColorEnabled)) {
%orig;
colorTrans = Opacityval/100;
UIColor *withOutAlpha= [UIColor colorFromHexString:kDockColorHex];



self.backgroundColor = [withOutAlpha colorWithAlphaComponent:colorTrans];

[self setBackgroundColor: [withOutAlpha colorWithAlphaComponent:colorTrans]];
return;
}
return %orig;
}
%end


%hook SBFloatyFolderBackgroundClipView
-(void)layoutSubviews {
if((kFolderColorEnabled)&&(kOpenFolderColorEnabled)) {
%orig;
colorTrans = Opacityval/100;
UIColor *withOutAlpha= [UIColor colorFromHexString:kDockColorHex];



self.backgroundColor = [withOutAlpha colorWithAlphaComponent:colorTrans];

[self setBackgroundColor: [withOutAlpha colorWithAlphaComponent:colorTrans]];
return;
}
return %orig;
}
%end

%hook SBFolderIconImageView
-(void)layoutSubviews {
if(kFolderColorEnabled) {
%orig;
colorTrans = Opacityval/100;
UIColor *withOutAlpha= [UIColor colorFromHexString:kDockColorHex];



self.backgroundColor = [withOutAlpha colorWithAlphaComponent:colorTrans];
return;
}
return %orig;
}

-(void)updateImageAnimated:(BOOL)animated {
if(kFolderColorEnabled) {
%orig;
colorTrans = Opacityval/100;
UIColor *withOutAlpha= [UIColor colorFromHexString:kDockColorHex];


self.backgroundColor = [withOutAlpha colorWithAlphaComponent:colorTrans];
return;
}
return %orig;
}
%end

%hook SBFolderIconBackgroundView
// iVar UIView *_solidColorBackgroundView

-(void)layoutSubviews {
if(kFolderColorEnabled) {
%orig;
colorTrans = Opacityval/100;
UIColor *withOutAlpha= [UIColor colorFromHexString:kDockColorHex];

/**** just added **********/
self.backgroundColor = [withOutAlpha colorWithAlphaComponent:colorTrans];
return;
}
return %orig;
}
%end



%hook SBDockView
-(void) setBackgroundAlpha:(double)arg1 {

if((kSlidersEnabled) && (kDockColorEnabled)){
trans= 0.f;
arg1 = trans;
colorTrans= Opacityval/100;
return %orig(arg1);
} 
else if (kSlidersEnabled) {


trans= Opacityval/100;

arg1= trans;
return %orig(arg1);
}
else {
return %orig; }
}

-(void)layoutSubviews {
if(kDockColorEnabled) {
%orig;
colorTrans = Opacityval/100;
UIColor *withOutAlpha= [UIColor colorFromHexString:kDockColorHex];


self.backgroundColor = [withOutAlpha colorWithAlphaComponent:colorTrans];

return;
}
return %orig;
}
%end

//FloatyDock compatibility

%hook SBFloatingDockPlatterView
-(void)layoutSubviews {
if(kDockColorEnabled) {
%orig;
colorTrans = Opacityval/100;
UIColor *withOutAlpha= [UIColor colorFromHexString:kDockColorHex];


self.backgroundColor = [withOutAlpha colorWithAlphaComponent:colorTrans];

return;
}
return %orig;
}
%end
/******
Added Dock Color and custom highlight color              
******/

%hook SBIconLabelImageParametersBuilder
-(void) setWantsFocusHighlight:(bool)arg1 {
if((kWantsClearHighlights) || (kWantsRandomHighlights) || (kCustomColorHighlights)) {
arg1= TRUE;
return %orig;
}
return %orig;
}

-(id) _focusHighlightColor {

if((kWantsRandomHighlights) || (kWantsClearHighlights) || (kCustomColorHighlights))
 {
//if there will be highlights

highlightAlph = highlightlevel/100;
} // end if there are highlights

if(kCustomColorHighlights) { 
 
customHighlightColor= [[UIColor colorFromHexString:kCustomHighlightHex] colorWithAlphaComponent:highlightAlph];
return customHighlightColor;

}
else
if(kWantsRandomHighlights) {
int r = arc4random_uniform(255);
int g = arc4random_uniform(255);
int b = arc4random_uniform(255);
rando[0]=  [UIColor colorWithRed:(r/255.0) 
green:(g/255.0) blue:(b/255.0) alpha: highlightAlph ];
int i=0;
while( i<200 )
{
r = arc4random_uniform(255);
 g = arc4random_uniform(255);
b = arc4random_uniform(255);
rando[i]= [UIColor colorWithRed:(r/255.0) 
green:(g/255.0) blue:(b/255.0) alpha: highlightAlph ];

i++;
} //end of while
i= arc4random_uniform(170);
return rando[(i+29)];
} //end of if  kWantsRandomHighlights

else if(kWantsClearHighlights) {
return  [UIColor colorWithRed:(238/255.0) green:(225/255.0) blue:(200/255.0) alpha: highlightAlph ];
} 

else {
return %orig; }
}
%end


%hook SBIconLabelImageParameters
-(id) textColor {
int i= 1;
if(kBlackText) {
return  [UIColor colorFromHexString:kIconHex];
}
else if(kRandomText) {
int r = arc4random_uniform(255);
int g = arc4random_uniform(255);
int b = arc4random_uniform(255);
rando[0]=  [UIColor colorWithRed:(r/255.0) 
green:(g/255.0) blue:(b/255.0) alpha: 1.0 ];
while ( i<=250 )
{
r = arc4random_uniform(255);
 g = arc4random_uniform(255);
b = arc4random_uniform(255);
rando[i]= [UIColor colorWithRed:(r/255.0) 
green:(g/255.0) blue:(b/255.0) alpha: 1.0 ];
i++;
}
i= arc4random_uniform(244);
return rando[(i+4)];
}
else {
return %orig; }
}
%end

%hook SBIconController
-(bool) iconViewDisplaysBadges:(id)arg1 {
if(kHideBadges) {
return FALSE;
return %orig;
}
return %orig;
}
%end


%hook SBUILegibilityLabel
-(void) setTextColor:(id)arg1 {
if(kRandomLS) {
int r = arc4random_uniform(255);
int g = arc4random_uniform(255);
int b = arc4random_uniform(255);
arg1= [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0];
return %orig;
}

else if(kBlackLS) {
arg1=  [UIColor colorFromHexString:kLockscreenHex];
return %orig;
}
else { 
return %orig;
}
}
%end

%hook UILabel
-(void)_setTextColor:(id)arg1 {
if(kRandomLabel) {
int r = arc4random_uniform(255);
int g = arc4random_uniform(255);
int b = arc4random_uniform(255);
arg1= [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0];
return %orig;
}

else if(kBlackLabel) {
arg1= [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1.0];
return %orig;
}
else { 
return %orig;
}
}

-(void)setTextColor:(id)arg1 {
if((kRandomLabel) || (kBlackLabel)) {
arg1=nil;
return %orig(arg1);
}
return %orig;
}
%end





%hook SBRootFolderView
-(void)_setDockOffscreenFraction:(double)arg1 {

if(kSlidersEnabled) {
dockheightfrac= dockpercent / 100;
arg1= dockheightfrac;
return %orig(arg1);
}
return %orig;
}

-(void)_applyDockOffscreenFraction:(CGFloat)arg1 {
   if(kSlidersEnabled)
    {
 
dockheightfrac= dockpercent / 100;
arg1= dockheightfrac;
return %orig(arg1);
}
return %orig(arg1); 
}

-(void)setDockOffscreenFraction:(double)arg1 {

if(kSlidersEnabled) {

dockheightfrac= dockpercent / 100;
arg1= dockheightfrac;
return %orig(arg1);
}
return %orig;
}
%end



%hook SBIconPageIndicatorImageSetResult
-(id) initWithIndicatorSet:(id)arg1 enabledIndicatorSet:(id)arg2 {
if(kHidePageDots) {
return nil;
%orig(arg1,arg2);
}
return %orig;
}
%end

%hook SBDashBoardPageControl

-(void) _setIndicatorImage:(id)arg1 toEnabled:(bool)arg2 index:(long long)arg3 {
if(kHidePageDots) {
arg2=false;
arg1=nil;
return %orig(arg1,arg2,arg3);
}
return %orig;
}

-(id) _pageIndicatorImage:(bool)arg1 {
if(kHidePageDots) {
arg1= FALSE;
return nil;
}
return %orig;
}

-(id) _indicatorViewEnabled:(bool)arg1 index:(long long)arg2 {
if(kHidePageDots) {
arg1=false;
return %orig(arg1,arg2);
}
return %orig;
}

-(id) _currentPageIndicatorColor {

bool kkey9= kHidePageDots;
if((kRandomPageDots) && (!kkey9)) {

return [UIColor colorWithRed:(cpiR/255.0) green:(cpiG/255.0) blue:(cpiB/255.0) alpha:1.0];
}
return %orig;
}

-(id)_pageIndicatorColor {
bool kkey9 = kHidePageDots;
if((kRandomPageDots) && (!kkey9)) {

return [UIColor colorWithRed:piR green:piG blue:piB alpha:1.0];
}
return %orig; 
}
%end


%hook UIPageControl
-(void) setCurrentPageIndicatorTintColor:(id)arg1 {
if(kRandomPageDots) {
r1 = arc4random_uniform(255);
 g1 = arc4random_uniform(255);
b1 = arc4random_uniform(255);

randocol= [UIColor colorWithRed:(cpiR/255.0) green:(cpiG/255.0) blue:(cpiB/255.0) alpha:1.0];
arg1= randocol;

return %orig(arg1);
}
return %orig;
}

-(void) setPageIndicatorTintColor:(id)arg1 {
if(kRandomPageDots) {
arg1= [UIColor colorWithRed:piR green:piG blue:piB alpha:1.0];
return %orig(arg1);
}
return %orig;
}
%end

%hook SBScreenFlash
-(void) _createUIWithColor:(id)arg1 {
 if(kHideScreenFlash) {

int rx = arc4random_uniform(255);
int gx = arc4random_uniform(255);
int bx = arc4random_uniform(255);
screenColor=  [UIColor colorWithRed:(rx/255.0) green:(gx/255.0) blue:(bx/255.0) alpha:1.0];
arg1= screenColor;
return %orig(arg1);
}
return %orig; 
}

-(void) flashColor:(id)arg1 withCompletion:(id)arg2 {
 if(kHideScreenFlash) {
arg1= screenColor;
return %orig(arg1,arg2);
}
else if(kScreenshotsDisabled) {
arg1= nil; 
return %orig(arg1,arg2);
}
return %orig;
}

-(void) flashWhiteWithCompletion:(id)arg1 {
if(kHideScreenFlash) {
arg1= nil;
return %orig(arg1);
}
else if (kScreenshotsDisabled) {
arg1=nil;
return %orig(arg1);
}
else {
return %orig;
}
}
%end 
 



%hook SSScreenshotsWindow
-(void) setContentsHidden:(bool)arg1 {
if (kHideScreenFlash) {
arg1= TRUE;
return %orig(arg1);
}
else if(kScreenshotsDisabled) {
arg1= FALSE;
return %orig(arg1);
}
else { return %orig; }
}


-(bool) contentsHidden {
if ((kHideScreenFlash) || (kScreenshotsDisabled)) {
return TRUE;
}
return %orig;
}
%end

%hook SSScreenCaptureAbilityCheck
-(bool) isAbleToTakeScreenshots { 
if (kHideScreenFlash) {
return YES;
} else
if(kScreenshotsDisabled) {
return FALSE;
}
else
{ return %orig; }
}

-(void) setReasonForNotBeingAbleToTakeScreenshots:(id)arg1 {
if((kScreenshotsDisabled) || (kHideScreenFlash)) {
arg1 = nil;
return %orig(arg1);
}
return %orig;
}

-(void) setIsAbleToTakeScreenshots:(bool)arg1 { 
if(kHideScreenFlash) {
arg1= TRUE;
return %orig(arg1);
} else
if(kScreenshotsDisabled) {
arg1 = FALSE;
return %orig(arg1);
}

else { return %orig; }
}
%end




%hook MTMaterialView
-(void) _setContinuousCornerRadius:(double)arg1 {
if(kSquareUI) {
arg1 = 0;
return %orig(arg1);
}

else if(kRoundUI) {
  arg1 = 35;
return %orig(arg1);
}
else {
return %orig; }
}

-(double)_continuousCornerRadius {
if(kSquareUI) {
return 0;
%orig;

}
else if(kRoundUI) {
kCCCornerRadius= 35;
return 35;
%orig;
}
else {
return %orig; }
}
%end


%hook CCUIContentModuleContentContainerView
-(void) _setContinuousCornerRadius:(CGFloat)arg1 {
if(kSquareUI) {
arg1 = 0;
return %orig(arg1);
}

else if(kRoundUI) {
  arg1 = 35;
return %orig(arg1);
}
else {
return %orig; }
}
%end

%hook CCUIPunchOutMask
-(unsigned long long) roundedCorners {
if(kSquareUI) {
kCCCornerRadius= 0;
return kCCCornerRadius;
}
else if(kRoundUI) {
kCCCornerRadius= 35;
return kCCCornerRadius ;
}
else {
return %orig; }
}
%end

%hook CCUIPunchOutMask
-(double) cornerRadius {
if(kSquareUI) {
kCCCornerRadius= 0;
return kCCCornerRadius;
}
else if(kRoundUI) {
kCCCornerRadius= 35;
return kCCCornerRadius ;
}
else {
return %orig; }
}
%end



%hook CCUIModuleSliderView
-(CGFloat)continuousSliderCornerRadius {
if(kSquareUI) {
return 0.f;
%orig;

}
else if(kRoundUI) {

return 35.f;
%orig;
}
else {
return %orig; }
}
%end

%hook CCUIVolumeSliderView
-(void)setContinuouSliderCornerRadius:(CGFloat)arg1 {
if(kSquareUI) {

arg1= 0;
return %orig;
}
else if(kRoundUI) {

arg1= 35 ;
return %orig;
}
else {
return %orig; }
}
%end


%hook CCUIRoundButton
-(void) _setCornerRadius:(double)arg1 {
if(kSquareUI) {
kCCCornerRadius= 0;
arg1= kCCCornerRadius;
return %orig(arg1);
}
else if(kRoundUI) {
kCCCornerRadius= 30;
arg1= kCCCornerRadius ;
return %orig(arg1);
}
else {
return %orig; }
}
%end

%hook CCUIRoundButton
-(double) _cornerRadius {
if(kSquareUI) {
kCCCornerRadius= 0;
return kCCCornerRadius;
%orig;
}
else if(kRoundUI) {
kCCCornerRadius= 30;
return kCCCornerRadius ;
%orig;
}
else {
return %orig; }
}
%end




%hook CCUIControlCenterButton
-(double) cornerRadius {
if(kSquareUI) {
return 0;
 %orig;
}
else if(kRoundUI) {
return 35;
 %orig;

}
else {
return %orig; }
}
%end



%hook CCUIMenuModuleItemView
-(void) _setContinuousCornerRadius:(double)arg1 {
if(kSquareUI) {
kCCContinuousControl = 0;
arg1 = kCCContinuousControl;
return %orig(arg1);
}
else if(kRoundUI) {
kCCContinuousControl= 35;
arg1= kCCContinuousControl ;
return %orig(arg1);
}
else {
return %orig; }
}
%end

/** NEW Addition **/

%hook CCUIControlCenterButton
-(bool)_isRectButton {
if(kSquareUI) {
return YES;
%orig;
}
return %orig;
}

-(bool)_isCircleButton {
if(kRoundUI) {
return YES;
%orig;
}
return %orig;
}
%end

static void
loadPrefs() {
    static NSUserDefaults *prefs = [[NSUserDefaults alloc]
                          initWithSuiteName:@"com.i0stweak3r.stylish11"];
    
   
kSlidersEnabled = [prefs boolForKey:@"SlidersEnabled"];
        
colorInt= [[prefs objectForKey:@"colorInt"] intValue];

wantsSpotlight= [prefs boolForKey:@"wantsSpotlight"];

Opacityval = [[prefs objectForKey:@"Opacityval"] doubleValue];

dockpercent = [[prefs objectForKey:@"dockpercent"] doubleValue];


highlightlevel = [[prefs objectForKey:@"highlightlevel"] doubleValue];

kWantsTranslucentFolders = [prefs boolForKey:@"wantsTranslucentFolders"];

kWantsNoLabels = [prefs boolForKey:@"wantsNoLabels"];

kHideAllButLabels =  [prefs boolForKey:@"hideAllButLabels"];
//was key35

kNoJitters = [prefs boolForKey:@"noJitters"];

kSquareUI =  [prefs boolForKey:@"isSquareCC"];

kRoundUI =  [prefs boolForKey:@"isCircularCC"];

kHideDotsAndX = [prefs boolForKey:@"hideDotsAndX"]; 
//was key6

kScreenshotsDisabled = [prefs boolForKey:@"screenshotsDisabled"]; 
//was key23

kSquareIcons =  [prefs boolForKey:@"squareIcons"]; 
//was key11

kCircularFolders =  [prefs boolForKey:@"circularFolders"]; 
//was key17

kWantsRandomHighlights = [prefs boolForKey:@"wantsColorfulHighlights"];
 //was key3

kWantsClearHighlights =  [prefs boolForKey:@"wantsClearHighlights"];
 //was key1

kBlackText = [prefs boolForKey:@"key2"];
 //key2 custom UILabel color

kRandomText = [prefs boolForKey:@"key22"];
 //key22

kBlackLabel = [prefs boolForKey:@"key16"];
 //key16 custom icon label enabled

kRandomLabel = [prefs boolForKey:@"key15"];
 //key15 random icon label colors enabled

kHideBadges =  [prefs boolForKey:@"key4"];
 //key4

kRandomLS =  [prefs boolForKey:@"key13"];
 //key13

kBlackLS = [prefs boolForKey:@"key14"];
 //key14= custom color for LS

kHidePageDots =  [prefs boolForKey:@"key9"];
 //key9
    
kHideScreenFlash = [prefs boolForKey:@"key25"];
 //key25

kRandomPageDots = [prefs boolForKey:@"key10"];
 //key10

kLockscreenHex = [[prefs objectForKey:@"LSColorHex"] stringValue];

kIconHex = [[prefs objectForKey:@"iconColorHex"] stringValue];

kDockColorEnabled = [prefs boolForKey:@"dockColorEnabled"];
			

kDockColorHex = [[prefs objectForKey:@"dockColorHex"] stringValue];

kCustomColorHighlights =  [prefs boolForKey:@"customColorHighlights"];

kCustomHighlightHex =  [[prefs objectForKey:@"customHighlightHex"] stringValue];

kFolderColorEnabled = [prefs boolForKey:@"folderColorEnabled"];

kOpenFolderColorEnabled = [prefs boolForKey:@"openFolderColorEnabled"];

}


%ctor {
    CFNotificationCenterAddObserver(
                                    CFNotificationCenterGetDarwinNotifyCenter(), NULL,
                                    (CFNotificationCallback)loadPrefs,
                                    CFSTR("com.i0stweak3r.stylish11/settingschanged"), NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
    loadPrefs();
}
