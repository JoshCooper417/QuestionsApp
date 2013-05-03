//
//  JALVoteButton.h
//  QuestionParse
//
//  Created by Joshua Cooper on 5/2/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface JALVoteButton : UIButton
@property(strong, nonatomic) PFObject* vote;
-(void) setVote:(PFObject*) vote;
- (id)initWithFrame:(CGRect)_frame;
@end
