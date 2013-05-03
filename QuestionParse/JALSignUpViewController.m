//
//  JALSignUpViewController.m
//  QuestionParse
//
//  Created by Joshua Cooper on 5/2/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import "JALSignUpViewController.h"

@interface JALSignUpViewController ()

@end

@implementation JALSignUpViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // customize the view
    [self.signUpView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"quest.png"]]];
    [self.signUpView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    [self.signUpView.signUpButton setImage:nil forState:UIControlStateNormal];
    [self.signUpView.signUpButton setImage:nil forState:UIControlStateHighlighted];
    [self.signUpView.signUpButton  setBackgroundImage:[UIImage imageNamed: @"signupbuttondown.png"] forState:UIControlStateHighlighted];
    [self.signUpView.signUpButton  setBackgroundImage:[UIImage imageNamed: @"signupbuttondown.png"] forState:UIControlStateHighlighted];
    
    [self.signUpView.signUpButton  setTitle:@"" forState:UIControlStateNormal];
    [self.signUpView.signUpButton  setTitle:@"" forState:UIControlStateHighlighted];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
