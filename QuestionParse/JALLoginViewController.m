//
//  JALLoginViewController.m
//  QuestionParse
//
//  Created by Joshua Cooper on 5/2/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import "JALLoginViewController.h"
#import "JALSignUpViewController.h"

@interface JALLoginViewController ()

@end

@implementation JALLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // customize the view
    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"quest.png"]]];
        [self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    
    // login buttin
    [self.logInView.logInButton setImage:nil forState:UIControlStateNormal];
    [self.logInView.logInButton setImage:nil forState:UIControlStateHighlighted];
    [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed: @"loginbutton.png"] forState:UIControlStateHighlighted];
     [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed: @"loginbutton.png"] forState:UIControlStateHighlighted];
    
[self.logInView.logInButton setTitle:@"" forState:UIControlStateNormal];
    [self.logInView.logInButton setTitle:@"" forState:UIControlStateHighlighted];
    

    
    
    //signup button
    [self.logInView.signUpButton setImage:nil forState:UIControlStateNormal];
    [self.logInView.signUpButton setImage:nil forState:UIControlStateHighlighted];
    [self.logInView.signUpButton  setBackgroundImage:[UIImage imageNamed: @"signuputton.png"] forState:UIControlStateHighlighted];
    [self.logInView.signUpButton  setBackgroundImage:[UIImage imageNamed: @"signupbuttondown.png"] forState:UIControlStateHighlighted];
    
    [self.logInView.signUpButton  setTitle:@"" forState:UIControlStateNormal];
    [self.logInView.signUpButton  setTitle:@"" forState:UIControlStateHighlighted];

    
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        JALLoginViewController *logInViewController = [[JALLoginViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        JALSignUpViewController *signUpViewController = [[JALSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    
    
    //CUSTOMIZE HERE
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
