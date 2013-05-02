//
//  JALNewQuestionViewController.h
//  QuestionParse
//
//  Created by Lauren Shapiro on 4/21/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JALNewQuestionViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *questionTextField;
@property (weak, nonatomic) IBOutlet UITextField *answer1TextField;
@property (weak, nonatomic) IBOutlet UITextField *answer2TextField;
@property (weak, nonatomic) IBOutlet UITextField *answer3TextField;
@property (weak, nonatomic) IBOutlet UITextField *answer4TextField;
- (IBAction)addButton:(id)sender;
@end
