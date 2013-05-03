//
//  JALNewQuestionViewController.m
//  QuestionParse
//
//  Created by Lauren Shapiro on 4/21/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import "JALNewQuestionViewController.h"
#import <Parse/Parse.h>
@interface JALNewQuestionViewController ()

@end

@implementation JALNewQuestionViewController


-(void)dismissKeyboard {
    [self.questionTextField resignFirstResponder];
    [self.answer1TextField resignFirstResponder];
    [self.answer2TextField resignFirstResponder];
    [self.answer3TextField resignFirstResponder];
    [self.answer4TextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.questionTextField resignFirstResponder];
    [self.answer1TextField resignFirstResponder];
    [self.answer2TextField resignFirstResponder];
    [self.answer3TextField resignFirstResponder];
    [self.answer4TextField resignFirstResponder];
    return NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // set up text delegates to resign keyboard
    self.questionTextField.delegate = self;
    self.answer1TextField.delegate = self;
    self.answer2TextField.delegate = self;
    self.answer3TextField.delegate = self;
    self.answer4TextField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO];
    
    // Adjust UI elements
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    
    [self.postButton setBackgroundImage:[UIImage imageNamed: @"postbutton.png"] forState:UIControlStateNormal];
    
    [self.postButton setBackgroundImage:[UIImage imageNamed: @"postbutton.png"] forState:UIControlStateHighlighted];
    
    
    [self.cancelButton setBackgroundImage:[UIImage imageNamed: @"cancelbutton.png"] forState:UIControlStateNormal];
    
    [self.cancelButton setBackgroundImage:[UIImage imageNamed: @"cancelbutton.png"] forState:UIControlStateHighlighted];
    
    self.questionLabel.font = [UIFont fontWithName:@"Avenir" size:22];
    
     self.answer1Label.font = [UIFont fontWithName:@"Avenir" size:18];
     self.answer2Label.font = [UIFont fontWithName:@"Avenir" size:18];
     self.answer3Label.font = [UIFont fontWithName:@"Avenir" size:18];
     self.answer4Label.font = [UIFont fontWithName:@"Avenir" size:18];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)addButton:(id)sender {
    
    // post a new question to the Parse data model
    PFObject* newquestion = [[PFObject alloc]initWithClassName:@"Question"];
    NSString* answer1 = _answer1TextField.text;
    NSString* answer2 = _answer2TextField.text;
    NSString* answer3 = _answer3TextField.text;
    NSString* answer4 = _answer4TextField.text;
    
    //Initial has the textfield inputs, which are possibly null. We put the non-null ones into Final, which we send to Parse.

    NSArray* answersInitial = [[NSArray alloc] initWithObjects:answer1,answer2, answer3, answer4, nil];
    NSMutableArray* answersFinal = [[NSMutableArray alloc] init];
    for(NSString* answer in answersInitial){
        if(answer.length>0){
            PFObject* newAnswer = [[PFObject alloc]initWithClassName:@"Answer"];
            [newAnswer setObject:answer forKey:@"AnswerString"];
            [answersFinal addObject:newAnswer];
        }
    }
    
    // check that input is valid
    NSString* newquestionString = _questionTextField.text;
    if([answersFinal count]==0 || newquestionString.length ==0){
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Uh oh"
                                                              message:@"You must have at least one answer option."
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
    }
    else {
    [newquestion setObject: answersFinal forKey:@"answerOptions"];
    PFObject* user = [PFUser currentUser];
    [user fetch];
        NSString* userId = user.objectId;
    [user addUniqueObject:newquestion forKey:@"MyQuestions"];
    [newquestion setObject:userId forKey:@"questionUser"];
    [newquestion setObject: newquestionString forKey:@"questionString"];
    
    [newquestion saveInBackground];
    [user saveInBackground];
    [self dismissViewControllerAnimated: YES completion: nil];
    }
}

- (IBAction)cancelButton:(id)sender {
      [self dismissViewControllerAnimated: YES completion: nil];
}






@end
