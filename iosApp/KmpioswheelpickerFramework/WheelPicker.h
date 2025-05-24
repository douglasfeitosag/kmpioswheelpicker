#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CustomWheelPickerDelegate <NSObject>
- (void)didSelectWithIndex:(NSInteger)index;
@end

@interface PickerView : UIPickerView

- (instancetype)initWithOptions:(NSArray<NSString *> *)options
        selectedIndex:(NSInteger)index;

@property (nonatomic, weak) id<CustomWheelPickerDelegate> pickerCallback;

@end

NS_ASSUME_NONNULL_END
