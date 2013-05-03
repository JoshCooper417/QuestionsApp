//
//  JALQuestionDetailViewController.h
//  QuestionParse
//
//  Created by Lauren Shapiro on 4/21/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface JALQuestionDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
- (IBAction)goBackButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *answers;
@property(weak,nonatomic) PFObject* currquestion;
@end
