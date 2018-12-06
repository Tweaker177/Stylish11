#include <stdlib.h>
#include <substrate.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.i0stweak3r.stylish11.plist"

static
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];


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


static void loadPrefs()
{
    if((prefs)&&(GetPrefBool(@"SlidersEnabled"))) 
    {
        Opacityval = [prefs objectForKey:@"Opacityval"] ? [[prefs objectForKey:@"Opacityval"] doubleValue] : Opacityval;

/**
textLevel = [prefs objectForKey:@"textLevel"] ? [[prefs objectForKey:@"textLevel"] floatValue] : textLevel;
textAlpha = textLevel / 100;
**/
    }
    [prefs release];
}

%ctor
{

CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.i0stweak3r.stylish11/settingsdiff"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}

%hook SBIconColorSettings
-(bool) blurryFolderIcons {
if(GetPrefBool(@"key8")) {
return FALSE;
}
return %orig;
}

-(double) colorAlpha {
if(GetPrefBool(@"key8")) {
return 0.5;
}
return %orig;
}

-(double) whiteAlpha {
if(GetPrefBool(@"key8")) {
return 0.5;
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



/**
%hook SSScreenshotsWindow
-(bool) _shouldAutorotateToInterfaceOrientation:(long long)arg1 {
return %orig;
}
%end

%hook SSScreenshotsWindow
-(bool) _shouldControlAutorotation {
return %orig;
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

%hook CCUIContentModuleContentContainerView
-(void) _setContinuousCornerRadius:(double)arg1 {
if(GetPrefBool(@"isSquareCC")) {
kCCContinuousControl = 0;
arg1 = kCCContinuousControl;
return %orig;
}
return %orig;
}
%end

%hook CCUIPunchOutMask
-(unsigned long long) roundedCorners {
if(GetPrefBool(@"isSquareCC")) {
kCCCornerRadius= 0;
return kCCCornerRadius;
}
return %orig;
}
%end

%hook CCUIPunchOutMask
-(double) cornerRadius {
if(GetPrefBool(@"isSquareCC")) {
kCCCornerRadius= 0;
return kCCCornerRadius;
}
return %orig;
}
%end


%hook CCUIRoundButton
-(void) _setCornerRadius:(double)arg1 {
if(GetPrefBool(@"isSquareCC")) {
kCCCornerRadius= 0;
arg1= kCCCornerRadius;
return %orig;
}
return %orig;
}
%end

%hook CCUIRoundButton
-(double) _cornerRadius {
if(GetPrefBool(@"isSquareCC")) {
kCCCornerRadius= 0;
return kCCCornerRadius;
}
return %orig;
}
%end

%hook CCUIControlCenterButton
-(void) setRoundCorners:(unsigned long long)arg1 {
if(GetPrefBool(@"isSquareCC")) {
kCCCornerRadius= 0;
arg1= kCCCornerRadius;;
return %orig;
}
return %orig;
}
%end

%hook CCUIControlCenterButton
-(double) cornerRadius {
if(GetPrefBool(@"isSquareCC")) {
kCCCornerRadius= 0;
return kCCCornerRadius;
}
return %orig;
}
%end


%hook CCUIMenuModuleItemView
-(void) _setContinuousCornerRadius:(double)arg1 {
if(GetPrefBool(@"isSquareCC")) {
kCCContinuousControl = 0;
arg1 = kCCContinuousControl;
return %orig;
}
return %orig;
}
%end

%hook CCUIControlCenterButton
-(unsigned long long) roundCorners {
if(GetPrefBool(@"isSquareCC")) {
kCCCornerRadius= 0;
return kCCCornerRadius;
}
return %orig;
}
%end
