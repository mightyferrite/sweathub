//
//  geekImageView.m
//  SweatHub
//
//  Created by John Reine on 9/28/15.
//  Copyright © 2015 John Reine. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MINIMUM_SCALE 0.5
#define MAXIMUM_SCALE 6.0


@interface geekImageView : UIImageView
@property CGPoint translation;
@end

@implementation geekImageView

- (id)initWithFishType:(FishType)fishType {
    
    self = [super init];
    if (self) {
        //my custom initialization
    }
    return self;
}


- (void)pan:(UIPanGestureRecognizer *)gesture {
    static CGPoint currentTranslation;
    static CGFloat currentScale = 0;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        currentTranslation = _translation;
        currentScale = self.view.frame.size.width / self.view.bounds.size.width;
    }
    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [gesture translationInView:self.view];
        
        _translation.x = translation.x + currentTranslation.x;
        _translation.y = translation.y + currentTranslation.y;
        CGAffineTransform transform1 = CGAffineTransformMakeTranslation(_translation.x , _translation.y);
        CGAffineTransform transform2 = CGAffineTransformMakeScale(currentScale, currentScale);
        CGAffineTransform transform = CGAffineTransformConcat(transform1, transform2);
        self.view.transform = transform;
    }
}


- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateChanged) {
        //        NSLog(@"gesture.scale = %f", gesture.scale);
        
        CGFloat currentScale = self.view.frame.size.width / self.view.bounds.size.width;
        CGFloat newScale = currentScale * gesture.scale;
        
        if (newScale < MINIMUM_SCALE) {
            newScale = MINIMUM_SCALE;
        }
        if (newScale > MAXIMUM_SCALE) {
            newScale = MAXIMUM_SCALE;
        }
        
        CGAffineTransform transform1 = CGAffineTransformMakeTranslation(_translation.x, _translation.y);
        CGAffineTransform transform2 = CGAffineTransformMakeScale(newScale, newScale);
        CGAffineTransform transform = CGAffineTransformConcat(transform1, transform2);
        self.view.transform = transform;
        gesture.scale = 1;
    }
}
@end
