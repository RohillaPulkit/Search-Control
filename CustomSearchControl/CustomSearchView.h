//
//  CustomSearchView.h
//  CustomSearchControl
//
//  Created by Pulkit Rohilla on 23/06/16.
//  Copyright © 2016 PulkitRohilla. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomSearchView;

@protocol CustomSearchViewProtocol

- (void)customSearchViewPressed:(CustomSearchView *)searchView;
- (void)customSearchViewCancelButtonClicked:(CustomSearchView *)searchView;
- (void)customSearchViewTextDidBeginEditing:(CustomSearchView *)searchView;
- (void)customSearchView:(CustomSearchView *)searchView textDidChange:(NSString *)searchText;

@end

IB_DESIGNABLE
@interface CustomSearchView : UIView <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet id <CustomSearchViewProtocol> delegate;

@property (nonatomic, strong) NSString *text;

-(void)makeFirstResponder;
-(void)resignFirstResponder;

-(void)activateSearchView;

@end
