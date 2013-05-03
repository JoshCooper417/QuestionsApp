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
    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"questionmark.jpg"]]];
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
