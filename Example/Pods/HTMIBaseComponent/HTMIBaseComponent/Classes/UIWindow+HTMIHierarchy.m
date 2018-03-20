

#import "UIWindow+HTMIHierarchy.h"

#if DEBUG

//#import "FLEXManager.h"

#endif

@implementation UIWindow (HTMIHierarchy)

- (UIViewController*)htmi_topMostController
{
    UIViewController *topController = [self rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}

- (UIViewController*)htmi_currentViewController;
{
    UIViewController *currentViewController = [self htmi_topMostController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    
    return currentViewController;
}

#if DEBUG
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [super motionBegan:motion withEvent:event];
    
    if (motion == UIEventSubtypeMotionShake) {
        //[[FLEXManager sharedManager] showExplorer];
        
    }
}
#endif

@end
