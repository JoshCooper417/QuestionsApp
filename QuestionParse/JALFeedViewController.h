//
//  JALFeedViewController.h
//  QuestionParse
//
//  Created by Lauren Shapiro on 4/21/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface JALFeedViewController : PFQueryTableViewController

- (IBAction)addQuestion:(id)sender;
@property (weak, nonatomic) UIButton* myQuestions;
@end
