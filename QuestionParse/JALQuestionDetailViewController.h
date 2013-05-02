//
//  JALQuestionDetailViewController.h
//  QuestionParse
//
//  Created by Lauren Shapiro on 4/21/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JALQuestionDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) NSString* questionLabelText;
- (IBAction)goBackButton:(id)sender;
-(void) setQuestionLabelText:(NSString *)questiontext;
@end
