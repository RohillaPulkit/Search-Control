//
//  ViewController.h
//  CustomSearchControl
//
//  Created by Pulkit Rohilla on 23/06/16.
//  Copyright © 2016 PulkitRohilla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSearchView.h"

@interface ViewController : UIViewController <CustomSearchViewProtocol>{
    
    __weak IBOutlet CustomSearchView *searchViewNew;
    
    __strong IBOutlet NSLayoutConstraint *constraintSVWidth;
    __weak IBOutlet NSLayoutConstraint *constraintSVRightHorizontalSpace;
    __weak IBOutlet NSLayoutConstraint *constraintSVLeftHorizontalSpace;
}


@end

