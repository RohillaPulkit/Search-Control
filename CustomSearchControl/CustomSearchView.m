//
//  CustomSearchView.m
//  CustomSearchControl
//
//  Created by Pulkit Rohilla on 23/06/16.
//  Copyright © 2016 PulkitRohilla. All rights reserved.
//

#import "CustomSearchView.h"

@implementation CustomSearchView{
    
    UILabel *lblSearchIcon;
    UITextField *txtFieldSearch;
    UIButton *btnCancel;
    UILongPressGestureRecognizer *longPressGesture;
    
    BOOL isActive;
    
    NSLayoutConstraint *lblSearchCentreX, *lblSearchCentreY;
    NSArray *arrayHorizontalConstraints;
    NSArray *arrayInitialHorizontalConstraints;

    CGFloat initialWidth;
}

NSString *iconSearch = @"";
NSString *iconCancel = @"";

NSString *fontAwesome = @"fontAwesome";

#pragma mark - UIView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        if (self.subviews.count == 0) {
            
            [self load];
        }
    }
    
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self load];
    }
    
    return self;
}

-(void)updateConstraints{

    if (isActive) {

        [self removeConstraint:lblSearchCentreX];
        [self removeConstraints:arrayInitialHorizontalConstraints];
        
        [self addConstraints:arrayHorizontalConstraints];
    }
    else
    {
        [self removeConstraints:arrayHorizontalConstraints];
        
        [self addConstraint:lblSearchCentreX];
        [self addConstraints:arrayInitialHorizontalConstraints];
    }
    
    [super updateConstraints];
}

#pragma mark - UILongPressGesture

- (void)actionViewPressed:(UILongPressGestureRecognizer *)sender {
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            
            [self highlightView:YES];
            
        } break;
        case UIGestureRecognizerStateChanged:{
            
            CGPoint location = [sender locationInView:sender.view];
            BOOL touchInside = CGRectContainsPoint(sender.view.bounds, location);
            if (!touchInside) {
                
                [self highlightView:NO];
            }
            else
            {
                [self highlightView:YES];
            }
            
        }break;
        case UIGestureRecognizerStateEnded: {
            
            [self highlightView:NO];

            CGPoint location = [sender locationInView:sender.view];
            BOOL touchInside = CGRectContainsPoint(sender.view.bounds, location);
            if (touchInside) {
                
                [self.delegate customSearchViewPressed:self];
            }
            
        } break;
        case UIGestureRecognizerStateCancelled: {
            
            [self highlightView:NO];

        } break;
        default: {
        } break;
    }
}

-(void)actionCancel{
    
    [self deactivateSearchView];
    [self.delegate customSearchViewCancelButtonClicked:self];
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{

    self.text = textField.text;
    
    [self.delegate customSearchViewTextDidBeginEditing:self];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == txtFieldSearch) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)textFieldDidChange:(UITextField *)textField{

    self.text = textField.text;

    [self.delegate customSearchView:self textDidChange:textField.text];
}

#pragma mark - OtherMethods

-(void)load{
    
    [self setupUI];
    [self addGestures];
    [self createConstraints];
}

-(void)setupUI{
    
    initialWidth = CGRectGetWidth(self.frame);
    
    self.layer.cornerRadius = initialWidth/2;
    self.layer.borderWidth = 0.5f;

    UIFont *fontFontAwesome = [UIFont fontWithName:fontAwesome size:16.0f];
    UIFont *fontFontAwesome2 = [UIFont fontWithName:fontAwesome size:20.0f];

    lblSearchIcon = [UILabel new];
    lblSearchIcon.text = iconSearch;
    lblSearchIcon.font = fontFontAwesome;
    lblSearchIcon.translatesAutoresizingMaskIntoConstraints = NO;
    lblSearchIcon.textAlignment = NSTextAlignmentCenter;
    
    [lblSearchIcon setOpaque:YES];

    txtFieldSearch = [UITextField new];
    txtFieldSearch.placeholder = @"Search";
    txtFieldSearch.translatesAutoresizingMaskIntoConstraints = NO;
    txtFieldSearch.hidden = YES;
    txtFieldSearch.delegate = self;
    txtFieldSearch.tintColor = [UIColor blackColor];
    [txtFieldSearch setOpaque:YES];
    [txtFieldSearch setReturnKeyType:UIReturnKeySearch];
    
    [txtFieldSearch addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    btnCancel = [UIButton buttonWithType:UIButtonTypeSystem];
    
    btnCancel.translatesAutoresizingMaskIntoConstraints = NO;
    btnCancel.titleLabel.font = fontFontAwesome2;
    btnCancel.hidden = YES;
    
    [btnCancel setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnCancel setTitle:iconCancel forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(actionCancel) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setOpaque:YES];

    [self addSubview:lblSearchIcon];
    [self addSubview:txtFieldSearch];
    [self addSubview:btnCancel];
    [self highlightView:NO];
}

-(void)addGestures{
    
    longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(actionViewPressed:)];
    [longPressGesture setNumberOfTouchesRequired:1];
    [longPressGesture setMinimumPressDuration:0.001];
    
    [self addGestureRecognizer:longPressGesture];
}

-(void)createConstraints{
    
    lblSearchCentreX = [NSLayoutConstraint constraintWithItem:lblSearchIcon
                                                    attribute:NSLayoutAttributeCenterX
                                                    relatedBy:0
                                                       toItem:self
                                                    attribute:NSLayoutAttributeCenterX
                                                   multiplier:1
                                                     constant:0];
    
    lblSearchCentreY = [NSLayoutConstraint constraintWithItem:lblSearchIcon
                                                    attribute:NSLayoutAttributeCenterY
                                                    relatedBy:0
                                                       toItem:self
                                                    attribute:NSLayoutAttributeCenterY
                                                   multiplier:1
                                                     constant:0];

    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(lblSearchIcon, txtFieldSearch, btnCancel);

    arrayInitialHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[lblSearchIcon(20)]-0-[txtFieldSearch(0)]-0-[btnCancel(0)]"
                                                                                options:NSLayoutFormatAlignAllCenterY
                                                                                metrics:nil
                                                                                  views:viewsDictionary];
    
    arrayHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[lblSearchIcon(20)]-8-[txtFieldSearch]-8-[btnCancel(35)]-4-|"
                                                                         options:NSLayoutFormatAlignAllCenterY
                                                                         metrics:nil
                                                                           views:viewsDictionary];
    
    [self addConstraint:lblSearchCentreY];

    
}

-(void)activateSearchView{
    
    isActive = YES;
    [longPressGesture setEnabled:NO];
    btnCancel.hidden = NO;
    txtFieldSearch.hidden = NO;
    
    self.layer.cornerRadius = 2.0f;
    
    [self updateConstraints];
}

-(void)deactivateSearchView{
    
    isActive = NO;
    [longPressGesture setEnabled:YES];
    btnCancel.hidden = YES;
    txtFieldSearch.hidden = YES;
    txtFieldSearch.text = nil;
    self.text = nil;
    
    self.layer.cornerRadius = initialWidth/2;

    [self updateConstraints];
}

-(void)makeFirstResponder{
    
    [txtFieldSearch becomeFirstResponder];
}

-(void)resignFirstResponder{
    
    [txtFieldSearch resignFirstResponder];
}

-(void)highlightView:(BOOL)highlight{
 
    if (highlight) {
        
        self.layer.borderColor = [UIColor darkGrayColor].CGColor;
        lblSearchIcon.textColor = [UIColor darkGrayColor];

    }
    else
    {
        self.layer.borderColor = [UIColor grayColor].CGColor;
        lblSearchIcon.textColor = [UIColor lightGrayColor];

    }
}

@end
