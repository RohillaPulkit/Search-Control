//
//  ViewController.m
//  CustomSearchControl
//
//  Created by Pulkit Rohilla on 23/06/16.
//  Copyright © 2016 PulkitRohilla. All rights reserved.
//

#import "ViewController.h"
#import <malloc/malloc.h>
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CustomSearchViewProtocol

-(void)customSearchViewPressed:(CustomSearchView *)searchView{
    
    [constraintSVWidth setActive:NO];
    [searchView activateSearchView];

    [UIView animateWithDuration:0.25 delay:0.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [self.view layoutIfNeeded];

    } completion:^(BOOL finished) {
        
        [searchView makeFirstResponder];
    }];
 
}

-(void)customSearchViewCancelButtonClicked:(CustomSearchView *)searchView{
    
    [constraintSVWidth setActive:YES];
    
    [UIView animateWithDuration:0.25 delay:0.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        [searchView resignFirstResponder];
    }];
}

-(void)customSearchView:(CustomSearchView *)searchView textDidChange:(NSString *)searchText{
    
    NSLog(@"%@",searchText);
}

-(void)customSearchViewTextDidBeginEditing:(CustomSearchView *)searchView{

    NSLog(@"%@",searchView.text);
}

@end
