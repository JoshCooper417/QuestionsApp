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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.questionLabel.text = self.questionLabelText;
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

-(void)setQuestionLabelText:(NSString *)questiontext
{
    _questionLabelText = questiontext;
}

@end
