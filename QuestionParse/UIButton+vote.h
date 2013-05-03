//
//  UIButton+vote.h
//  QuestionParse
//
//  Created by Joshua Cooper on 5/2/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface UIButton (vote)
@property (nonatomic, retain)PFObject *property;
-(void) setVote:(PFObject*) newVote;
@end
