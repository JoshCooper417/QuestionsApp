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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    
    
    return self;
}

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addButton:(id)sender {
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
            [answersFinal addObject:answer];
        }
    }
    NSString* newquestionString = _questionTextField.text;
    if([answersFinal count]==0 || newquestionString.length ==0){
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Uh oh"
                                                              message:@"You must have at least one answer option."
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
    }
    else{
    [newquestion setObject: newquestionString forKey:@"questionString"];
    [newquestion setObject: answersFinal forKey:@"answerOptions"];
    [newquestion saveInBackground];
    [self dismissViewControllerAnimated: YES completion: nil];
    }
}






@end
