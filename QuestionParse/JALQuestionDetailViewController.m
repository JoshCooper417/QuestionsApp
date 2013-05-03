//
//  JALQuestionDetailViewController.m
//  QuestionParse
//
//  Created by Lauren Shapiro on 4/21/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import "JALQuestionDetailViewController.h"

@interface JALQuestionDetailViewController ()

@end

@implementation JALQuestionDetailViewController

NSString* questionLabelText;
NSArray* answersArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.questionLabel.text = questionLabelText;
    NSMutableString* ansText = [[NSMutableString alloc] init];
    for(PFObject* answer in answersArray){
        [answer fetch];
        NSString *answerString = [answer objectForKey:@"AnswerString"];
        [ansText appendString:answerString];
    }
    self.answers.text=ansText;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackButton:(id)sender {
    [self dismissViewControllerAnimated: YES completion: nil];
}

-(void) setData:(PFObject *)currquestion
{ 
    questionLabelText = [currquestion objectForKey:@"questionString"];
    answersArray = [currquestion objectForKey:@"answerOptions"];
}

@end
