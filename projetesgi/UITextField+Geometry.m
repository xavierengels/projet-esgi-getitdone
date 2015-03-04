


#import "UITextField+Geometry.h"

@implementation UITextField (Geometry)
- (void)setPaddingLeftTo:(NSUInteger)padding{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, padding, self.frame.size.height)];
    leftView.backgroundColor = self.backgroundColor;
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}
@end
