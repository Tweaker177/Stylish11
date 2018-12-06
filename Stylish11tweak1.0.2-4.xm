#include <stdlib.h>
#include <substrate.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.i0stweak3r.stylish11.plist"
/**
static
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];

**/

double dockpercent = 0.f;
double dockheightfrac = dockpercent/100;
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

/**
static CGFloat textLevel=
100;
static CGFloat textAlpha =
textLevel/100;
**/

static UIColor *screenColor;
static double kCCContinuousControl;
static double kCCCornerRadius;

inline bool GetPrefBool(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}


@interface UIColor (myColors)
+(UIColor *)randomSpot;
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
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];

colorInt= [[prefs objectForKey:@"colorInt"] intValue];
wantsSpotlight= [[prefs objectForKey:@"wantsSpotlight"] boolValue];

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
if(GetPrefBool(@"key8")) {
return FALSE;

}
return %orig;
}

-(double) colorAlpha {
if(GetPrefBool(@"key8")) {
return 0.1;
}
return %orig;
}

-(double) whiteAlpha {
if(GetPrefBool(@"key8")) {
return 0.1;

}
return %orig;
}
%end

%hook SBFWallpaperSettings
-(bool) replaceBlurs {
if(GetPrefBool(@"key8")) {
return TRUE;
}
return %orig;
}
%end

%hook SBIconView
-(void) setIconLabelAlpha:(double)arg1 {
if(GetPrefBool(@"key36")) {
/**
if(prefs) {
textLevel = [prefs objectForKey:@"textLevel"] ? [[prefs objectForKey:@"textLevel"] floatValue] : textLevel;
textAlpha = textLevel / 100;
**/
arg1= 0;
return %orig(arg1);
}
/**
arg1= textAlpha;
return %orig(arg1);
**/
return %orig;
}
%end

/**
if(GetPrefBool(@"key36")&&(!GetPrefBool(@"SlidersEnabled"))) {
arg1=0;
return %orig;
}
else if(GetPrefBool(@"key36")) {
arg1=0;
highlightLevel=0;
highlightAlph=0;
return %orig;
}
else {
return %orig; }
}
%end    
**/
//transparent labels

%hook SBIconView
-(void) setAllIconElementsButLabelToHidden:(bool)arg1 {
if(GetPrefBool(@"key35")) {
arg1=TRUE;
return %orig;
}
return %orig;
}
//Hide everything but labels on icons

-(void) _applyIconImageAlpha:(double)arg1 {
if(GetPrefBool(@"key35")) {
arg1=0;
return %orig;
}
return %orig;
}

//Hide All But Labels

-(void) setIconImageAndAccessoryAlpha:(double)arg1 {
if(GetPrefBool(@"key35")) {
arg1=0;
return %orig(arg1);
}
return %orig;
}
%end
//Set alpha to zero to hide icons n folders


%hook SBIconView
-(void) setLabelAccessoryViewHidden:(bool)arg1 {
if(GetPrefBool(@"key35")) {
arg1=TRUE;
return %orig;
}
return %orig;
} 


-(void) setIconAccessoryAlpha:(double)arg1 {
if((GetPrefBool(@"key35")) || (GetPrefBool(@"key6"))) {
arg1=0;
return %orig;
}
/*
else if(GetPrefBool(@"key17")) {
arg1=0; */

return %orig;
 /**
}
else { return %orig; } **/
}
//Hide Accessory View(dots)


-(void) _applyIconAccessoryAlpha:(double)arg1 {
if((GetPrefBool(@"key35")) || (GetPrefBool(@"key6"))) {
arg1=0;
return %orig;
}
return %orig; 
}


+(bool) canShowLabelAccessoryView {
if((GetPrefBool(@"key35")) || (GetPrefBool(@"key6"))) {
return FALSE;
}
return %orig;
}
//hide tiny icon dots and X's to delete

-(void) showDropGlow:(bool)arg1 {
if(GetPrefBool(@"key18")) {
arg1= TRUE;
return %orig;
}
return %orig;
}
%end
//Show Drop G
%hook SBIconImageView
+(double)cornerRadius {
if(GetPrefBool(@"key17")) {
return 28.5f;
}
else 
if(GetPrefBool(@"key11")) {
return 0.f;
}
else {
return %orig; }
}

-(BOOL)showsSquareCorners{
if(GetPrefBool(@"key11")) {
return TRUE;
} 
return %orig; 
}

-(void)setShowsSquareCorners:(BOOL)arg1 {
if(GetPrefBool(@"key11")) {
arg1=TRUE;
return %orig(arg1);
} /**
else if(GetPrefBool(@"key17")) {
arg1= FALSE;
return %orig(arg1);
}
else { **/
return %orig; 
}
%end

%hook SBIconColorSettings
-(bool)suppressJitter {
if(GetPrefBool(@"key12")) {
return TRUE;
}
return %orig;
}

-(void)setSupressJitter:(bool)arg1{
if(GetPrefBool(@"key12")) {
arg1=TRUE;
return %orig;
}
return %orig;
}
%end

%hook SBIconView
-(void) setAllowsJitter:(bool)arg1 {
if(GetPrefBool(@"key12")) {
arg1=FALSE;
return %orig;
}
return %orig;
}
-(void) setAllowJitter:(bool)arg1 {
if(GetPrefBool(@"key12")) {
arg1=FALSE;
return %orig;
}
return %orig;
}

-(bool)allowsJitter {
if(GetPrefBool(@"key12")) {
return FALSE;
}
return %orig;
}
%end

%hook SBIconImageView
-(BOOL)isJittering {
if(GetPrefBool(@"key12")) {
return FALSE;
}
return %orig;
}

-(void)setJittering:(BOOL)arg1 {
if(GetPrefBool(@"key12")) {
arg1=FALSE;
return %orig;
}
return %orig;
}
%end



%hook SBDockView
-(void) setBackgroundAlpha:(double)arg1 {

NSMutableDictionary *prefs2 = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH]; 

if(GetPrefBool(@"SlidersEnabled") && (prefs2))
{
        Opacityval = [prefs2 objectForKey:@"Opacityval"] ? [[prefs2 objectForKey:@"Opacityval"] doubleValue] : Opacityval;

trans= Opacityval/100;

arg1= trans;
return %orig(arg1);
}
return %orig;
}
%end

static void loadPrefs9()
{
NSMutableDictionary *prefs9 = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];
    
    if((prefs9)&&(GetPrefBool(@"SlidersEnabled"))) 
    {
        Opacityval = [prefs9 objectForKey:@"Opacityval"] ? [[prefs9 objectForKey:@"Opacityval"] doubleValue] : Opacityval;

/**
textLevel = [prefs objectForKey:@"textLevel"] ? [[prefs objectForKey:@"textLevel"] floatValue] : textLevel;
textAlpha = textLevel / 100;
**/
    }
    [prefs9 release];
}

%ctor
{

CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs9, CFSTR("com.i0stweak3r.stylish11/settingsdiff"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs9();
}




%hook SBIconLabelImageParametersBuilder
-(void) setWantsFocusHighlight:(bool)arg1 {
if((GetPrefBool(@"key1")) || (GetPrefBool(@"key3"))) {
arg1= TRUE;
return %orig;
}
return %orig;
}

-(id) _focusHighlightColor {

if((GetPrefBool(@"key3")) || (GetPrefBool(@"key1")))
 {
//if there will be highlights

NSMutableDictionary *prefs3 = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];


    if((prefs3)&&(GetPrefBool(@"SlidersEnabled"))) {
    
        highlightlevel = [prefs3 objectForKey:@"highlightlevel"] ? [[prefs3 objectForKey:@"highlightlevel"] doubleValue] : highlightlevel;

highlightAlph = highlightlevel/100;
 }
} // end if there are highlights

if(GetPrefBool(@"key3")) {
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
} //end of if key3 

else if(GetPrefBool(@"key1")) {
return  [UIColor colorWithRed:(238/255.0) green:(225/255.0) blue:(200/255.0) alpha: highlightAlph ];
} 

else { 
return %orig; }
}
%end

static void loadPrefs4()
{
        NSMutableDictionary *prefs4 = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];
    if((prefs4)&&(GetPrefBool(@"SlidersEnabled"))) 
    {
        highlightlevel = [prefs4 objectForKey:@"highlightlevel"] ? [[prefs4 objectForKey:@"highlightlevel"] doubleValue] : highlightlevel;
    }
    [prefs4 release];
}


%ctor
{

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs4, CFSTR("com.i0stweak3r.stylish11/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs4();
}


%hook SBIconLabelImageParameters
-(id) textColor {
int i= 1;
if(GetPrefBool(@"key2")) {
return  [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1.0];
}
else if(GetPrefBool(@"key22")) {
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


/*  
Use this to set primary color 
%hook SBIconView
-(id) _legibilitySettingsWithStyle:(long long)arg1 primaryColor:(id)arg2 {
if(GetPrefBool(@"key2")) { 
arg2=  [UIColor colorWithRed:(226/255.0) green:(215/255.0) blue:(36/255.0) alpha:1.0];

return %orig(arg1,arg2);
}
return %orig;
}
%end
*/


%hook SBIconController
-(bool) iconViewDisplaysBadges:(id)arg1 {
if(GetPrefBool(@"key4")) {
return FALSE;
return %orig;
}
return %orig;
}
%end


%hook SBUILegibilityLabel
-(void) setTextColor:(id)arg1 {
if(GetPrefBool(@"key13")) {
int r = arc4random_uniform(255);
int g = arc4random_uniform(255);
int b = arc4random_uniform(255);
arg1= [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0];
return %orig;
}

else if(GetPrefBool(@"key14")) {
arg1= [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1.0];
return %orig;
}
else { 
return %orig;
}
}
%end

%hook UILabel
-(void)_setTextColor:(id)arg1 {
if(GetPrefBool(@"key15")) {
int r = arc4random_uniform(255);
int g = arc4random_uniform(255);
int b = arc4random_uniform(255);
arg1= [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0];
return %orig;
}

else if(GetPrefBool(@"key16")) {
arg1= [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1.0];
return %orig;
}
else { 
return %orig;
}
}

-(void)setTextColor:(id)arg1 {
if((GetPrefBool(@"key15")) || (GetPrefBool(@"key16"))) {
arg1=nil;
return %orig(arg1);
}
return %orig;
}
%end


static void loadPrefs6()
{
        NSMutableDictionary *prefs6 = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];
    if(prefs6)
    {
        dockpercent = [prefs6 objectForKey:@"dockpercent"] ? [[prefs6 objectForKey:@"dockpercent"] doubleValue] : dockpercent;
    }
    [prefs6 release];
}

%ctor
{

CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs6, CFSTR("com.i0stweak3r.stylish11/settingsnew"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs6();
}




%hook SBRootFolderView
-(void)_setDockOffscreenFraction:(double)arg1 {

if(GetPrefBool(@"SlidersEnabled")) {
NSMutableDictionary *prefs5 = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];

dockpercent = [prefs5 objectForKey:@"dockpercent"] ? [[prefs5 objectForKey:@"dockpercent"] doubleValue] : dockpercent;
    /**
if(settings != nil && [[settings objectForKey:@"SlidersEnabled"] boolValue]) {
dockpercent = [settings  objectForKey:@"dockpercent"] ? [[settings  objectForKey:@"dockpercent"] doubleValue] : dockpercent;
**/
dockheightfrac= dockpercent / 100;
arg1= dockheightfrac;
return %orig(arg1);
}
return %orig;
}

-(void)_applyDockOffscreenFraction:(CGFloat)arg1 {

NSMutableDictionary *prefs5 = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];
   if(GetPrefBool(@"SlidersEnabled"))
    {
dockpercent = [prefs5 objectForKey:@"dockpercent"] ? [[prefs5 objectForKey:@"dockpercent"] doubleValue] : dockpercent;
    /**
if(settings != nil  && [[settings objectForKey:@"SlidersEnabled"] boolValue]) {
dockpercent = [settings  objectForKey:@"dockpercent"] ? [[settings  objectForKey:@"dockpercent"] doubleValue] : dockpercent;
**/
dockheightfrac= dockpercent / 100;
arg1= dockheightfrac;
return %orig(arg1);
}
return %orig(arg1); 
}

-(void)setDockOffscreenFraction:(double)arg1 {

if(GetPrefBool(@"SlidersEnabled")) {
NSMutableDictionary *prefs5 = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];

dockpercent = [prefs5 objectForKey:@"dockpercent"] ? [[prefs5 objectForKey:@"dockpercent"] doubleValue] : dockpercent;
    /**
if(settings != nil && [[settings objectForKey:@"SlidersEnabled"] boolValue]) {
dockpercent = [settings  objectForKey:@"dockpercent"] ? [[settings  objectForKey:@"dockpercent"] doubleValue] : dockpercent;
**/

dockheightfrac= dockpercent / 100;
arg1= dockheightfrac;
return %orig(arg1);
}
return %orig;
}
%end

static void loadPrefs10()
{
        NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];
    if(prefs)
    {
        wantsSpotlight = ([prefs objectForKey:@"wantsSpotlight"] ? [[prefs objectForKey:@"wantsSpotlight"] boolValue] : NO);

colorInt = ([prefs objectForKey:@"colorInt"] ? [[prefs objectForKey:@"colorInt"] intValue] : colorInt);


    }
    [prefs release];
}

static void settingschanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    loadPrefs10();
}


%ctor
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, settingschanged, CFSTR("com.i0stweak3r.stylish11/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs10();
}









%hook SBIconPageIndicatorImageSetResult
-(id) initWithIndicatorSet:(id)arg1 enabledIndicatorSet:(id)arg2 {
if(GetPrefBool(@"key9")) {
return nil;
%orig(arg1,arg2);
}
return %orig;
}
%end

%hook SBDashBoardPageControl

-(void) _setIndicatorImage:(id)arg1 toEnabled:(bool)arg2 index:(long long)arg3 {
if(GetPrefBool(@"key9")) {
arg2=false;
arg1=nil;
return %orig(arg1,arg2,arg3);
}
return %orig;
}

-(id) _pageIndicatorImage:(bool)arg1 {
if(GetPrefBool(@"key9")) {
arg1= FALSE;
return nil;
}
return %orig;
}

-(id) _indicatorViewEnabled:(bool)arg1 index:(long long)arg2 {
if(GetPrefBool(@"key9")) {
arg1=false;
return %orig(arg1,arg2);
}
return %orig;
}

-(id) _currentPageIndicatorColor {

bool kkey9= GetPrefBool(@"key9");
if((GetPrefBool(@"key10")) && (!kkey9)) {

return [UIColor colorWithRed:(cpiR/255.0) green:(cpiG/255.0) blue:(cpiB/255.0) alpha:1.0];
}
return %orig;
}

-(id)_pageIndicatorColor {
bool kkey9 = GetPrefBool(@"key9");
if((GetPrefBool(@"key10")) && (!kkey9)) {

return [UIColor colorWithRed:piR green:piG blue:piB alpha:1.0];
}
return %orig; 
}
%end


%hook UIPageControl
-(void) setCurrentPageIndicatorTintColor:(id)arg1 {
if(GetPrefBool(@"key10")) {
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
if(GetPrefBool(@"key10")) {
arg1= [UIColor colorWithRed:piR green:piG blue:piB alpha:1.0];
return %orig(arg1);
}
return %orig;
}
%end

%hook SBScreenFlash
-(void) _createUIWithColor:(id)arg1 {
 if(GetPrefBool(@"key25")) {

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
 if(GetPrefBool(@"key25")) {
arg1= screenColor;
return %orig(arg1,arg2);
}
else if(GetPrefBool(@"key23") || (GetPrefBool(@"key24"))) {
arg1= nil; 
return %orig(arg1,arg2);
}
return %orig;
}

-(void) flashWhiteWithCompletion:(id)arg1 {
if(GetPrefBool(@"key25")) {
arg1= nil;
return %orig(arg1);
}
else if ((GetPrefBool(@"key23") || (GetPrefBool(@"key24")))) {
arg1=nil;
return %orig(arg1);
}
else {
return %orig;
}
}
%end 
 

%hook SSScreenCaptureAbilityCheck
-(void) setIsAbleToTakeScreenshots:(bool)arg1 { 
if(GetPrefBool(@"key25")) {
arg1= TRUE;
return %orig(arg1);
} else
if(GetPrefBool(@"key23")) {
arg1 = FALSE;
return %orig(arg1);
}

else { return %orig; }
}
%end

%hook SSScreenshotsWindow
-(void) setContentsHidden:(bool)arg1 {
if (GetPrefBool(@"key25")) {
arg1= TRUE;
return %orig(arg1);
}
else if(GetPrefBool(@"key23")) {
arg1= FALSE;
return %orig(arg1);
}
else { return %orig; }
}


-(bool) contentsHidden {
if (GetPrefBool(@"key25") || (GetPrefBool(@"key23"))) {
return TRUE;
}
return %orig;
}
%end

%hook SSScreenCaptureAbilityCheck
-(bool) isAbleToTakeScreenshots { 
if  (GetPrefBool(@"is key25")) {
return YES;;
} else
if(GetPrefBool(@"is key23")) {
return FALSE;
}
else
{ return %orig; }
}
%end

%hook SSScreenCaptureAbilityCheck
-(void) setReasonForNotBeingAbleToTakeScreenshots:(id)arg1 {
if(GetPrefBool(@"key23") || (GetPrefBool(@"key25"))) {
arg1 = nil;
return %orig(arg1);
}
return %orig;
}
%end

/**
%hook 
-(id) reasonForNotBeingAbleToTakeScreenshots {
if(GetPrefBool(@"key23")) {
return nil;
}
return %orig;
}
%end
**/

/***
%hook SSScreenCapturer
+(void) playScreenshotSound {
%orig;
if(GetPrefBool(@"key24")) {

SystemSoundID *inSystemSound;
SystemSoundID *outSystemSoundID;
CFURLRef *inFileURL;
SystemSoundID.inFileURL= @" ";
if (self) { 
self.SystemSoundID.inFileURL= @" ";
self.outSystemSoundID= nil;
OSStatus AudioServicesDisposeSystemSoundID(SystemSoundID inSystemSound);
}
return;
} 
return;
}
%end
**/



/*** Control Center


%hook CCUIControlCenterSlider
-(void) setMinimumValueImage:(id)arg1 {
if(GetPrefBool(@"key12")) {
arg1 =nil ;
return %orig;
}
return %orig;
}

-(void) setMaximumValueImage:(id)arg1 {
if(GetPrefBool(@"key12")) {
arg1 =nil ;
return %orig;
}
return %orig;
}
%end

%hook SBUIControlCenterSlider
-(void) setMinimumValueImage:(id)arg1 {
if(GetPrefBool(@"key12")) {
arg1 = nil;
return %orig;
}
return %orig;
}

-(void) setMaximumValueImage:(id)arg1 {
if(GetPrefBool(@"key12")) {
arg1 = nil;
return %orig;
}
return %orig;
}
%end

%hook SBCCAirStuffSectionController
-(bool) enabledForOrientation:(long long)arg1 {
if(GetPrefBool(@"key17")) {
return FALSE;
}
return %orig;
}

-(void) _dismissAirplayControllerAnimated:(bool)arg1 {
if(GetPrefBool(@"key17")) {
arg1= TRUE;
return %orig;
}
return %orig;
}
%end

%hook CCUIAirStuffSectionController
-(bool) enabled {
if(GetPrefBool(@"key17")) {
return FALSE;
}
return %orig;
}
%end

%hook SBCCNightShiftSetting
-(bool) isRestricted {
if(GetPrefBool(@"key18")) {
return TRUE;
}
return %orig;
}
%end

%hook CCUINightShiftSectionController
-(bool) enabled {
if(GetPrefBool(@"key18")) {
return false;
}
return %orig;
}
%end;

%hook CCUIControlCenterPageContainerViewController
-(long long) layoutStyle {
if(GetPrefBool(@"key35")) {
%orig;
return 1;
}
return %orig;
}
%end


%end

   %ctor {

	@autoreleasepool {
		settings = [[NSMutableDictionary alloc] initWithContentsOfFile:[kStylish11 stringByExpandingTildeInPath]];
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) PreferencesChangedCallback, CFSTR("com.i0stweak3r.stylish11.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
		refreshPrefs();
		%init(main);
	}
}
***/

%hook MTMaterialView
-(void) _setContinuousCornerRadius:(double)arg1 {
if(GetPrefBool(@"isSquareCC")) {
arg1 = 0;
return %orig(arg1);
}

else if(GetPrefBool(@"isCircularCC")) {
  arg1 = 35;
return %orig(arg1);
}
else {
return %orig; }
}

-(double)_continuousCornerRadius {
if(GetPrefBool(@"isSquareCC")) {
return 0;
%orig;

}
else if(GetPrefBool(@"isCircularCC")) {
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
if(GetPrefBool(@"isSquareCC")) {
arg1 = 0;
return %orig(arg1);
}

else if(GetPrefBool(@"isCircularCC")) {
  arg1 = 35;
return %orig(arg1);
}
else {
return %orig; }
}
%end
/**
%hook CCUIPunchOutMask
- (id)initWithFrame:(struct CGRect { struct CGPoint { double x_1_1_1; double x_1_1_2; } x1; struct CGSize { double x_2_1_1; double x_2_1_2; } x2; })arg1 style:(long long)arg2 radius:(double)arg3 roundedCorners:(unsigned long long)arg4 {
if(GetPrefBool(@"isSquareCC")) {
arg3= 0; 
arg4=0;
return %orig;
}
else if(GetPrefBool(@"isCircularCC")) {
arg3= 35;
return %orig;
}
else {
return %orig; }
}
%end
**/
%hook CCUIPunchOutMask
-(unsigned long long) roundedCorners {
if(GetPrefBool(@"isSquareCC")) {
kCCCornerRadius= 0;
return kCCCornerRadius;
}
else if(GetPrefBool(@"isCircularCC")) {
kCCCornerRadius= 35;
return kCCCornerRadius ;
}
else {
return %orig; }
}
%end

%hook CCUIPunchOutMask
-(double) cornerRadius {
if(GetPrefBool(@"isSquareCC")) {
kCCCornerRadius= 0;
return kCCCornerRadius;
}
else if(GetPrefBool(@"isCircularCC")) {
kCCCornerRadius= 35;
return kCCCornerRadius ;
}
else {
return %orig; }
}
%end

/**
%hook MediaControlsPanelViewController
-(id) backgroundView {
%orig;
UIView *view = [super init];
if(GetPrefBool(@"isSquareCC")) {
view.continuousCornerRadius = 0;
view.cornerRadius = 0;
[self insertSubview:view atIndex:0];
}
else if(GetPrefBool(@"isCircularCC")) {
view.cornerRadius= 35;
view.continuousCornerRadius= 35 ;
[self insertSubview:view atIndex:0];
}
else {
return %orig; }
}

%end
**/

%hook CCUIVolumeSliderView
-(void)setContinuouSliderCornerRadius:(CGFloat)arg1 {
if(GetPrefBool(@"isSquareCC")) {

arg1= 0;
return %orig;
}
else if(GetPrefBool(@"isCircularCC")) {

arg1= 35 ;
return %orig;
}
else {
return %orig; }
}
%end


%hook CCUIRoundButton
-(void) _setCornerRadius:(double)arg1 {
if(GetPrefBool(@"isSquareCC")) {
kCCCornerRadius= 0;
arg1= kCCCornerRadius;
return %orig(arg1);
}
else if(GetPrefBool(@"isCircularCC")) {
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
if(GetPrefBool(@"isSquareCC")) {
kCCCornerRadius= 0;
return kCCCornerRadius;
%orig;
}
else if(GetPrefBool(@"isCircularCC")) {
kCCCornerRadius= 30;
return kCCCornerRadius ;
%orig;
}
else {
return %orig; }
}
%end

%hook CCUIModuleSliderView
-(CGFloat)continuousSliderCornerRadius {
if(GetPrefBool(@"isSquareCC")) {
return 0;
%orig;

}
else if(GetPrefBool(@"isCircularCC")) {
kCCCornerRadius= 35;
/** just changed 
return kCCCornerRadius ;
**/
return 35;
%orig;
}
else {
return %orig; }
}
%end
/**
%hook CCUIControlCenterButton
-(void) setRoundCorners:(unsigned long long)arg1 {
if(GetPrefBool(@"isSquareCC")) {
kCCCornerRadius= 0;
arg1= kCCCornerRadius;;
return %orig(arg1);
}
else if(GetPrefBool(@"isCircularCC")) {
kCCCornerRadius= 35;
arg1= kCCCornerRadius ;
return %orig(arg1);
}
else {
return %orig; }
}
%end
just deleted
**/


%hook CCUIControlCenterButton
-(double) cornerRadius {
if(GetPrefBool(@"isSquareCC")) {
/** just changed 
kCCCornerRadius= 0; **/
return 0;
 %orig;
}
else if(GetPrefBool(@"isCircularCC")) {
/**
kCCCornerRadius= 35;
return kCCCornerRadius ;
**/
return 35;
 %orig;

}
else {
return %orig; }
}
%end



%hook CCUIMenuModuleItemView
-(void) _setContinuousCornerRadius:(double)arg1 {
if(GetPrefBool(@"isSquareCC")) {
kCCContinuousControl = 0;
arg1 = kCCContinuousControl;
return %orig(arg1);
}
else if(GetPrefBool(@"isCircularCC")) {
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
if(GetPrefBool(@"isSquareCC")) {
return YES;
%orig;
}
return %orig;
}

-(bool)_isCircleButton {
if(GetPrefBool(@"isCircularCC")) {
return YES;
%orig;
}
return %orig;
}
%end
/**
%hook CCUIControlCenterButton
-(unsigned long long) roundCorners {
if(GetPrefBool(@"isSquareCC")) {
kCCCornerRadius= 0;
return kCCCornerRadius;
%orig;
}
else if(GetPrefBool(@"isCircularCC")) {
kCCCornerRadius= 35;
return kCCCornerRadius;
%orig;
}
else {
return %orig; }
}
%end
**/