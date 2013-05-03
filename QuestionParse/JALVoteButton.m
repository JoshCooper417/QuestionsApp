//
//  JALVoteButton.m
//  QuestionParse
//
//  Created by Joshua Cooper on 5/2/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import "JALVoteButton.h"

@implementation JALVoteButton

- (id)initWithFrame:(CGRect)_frame
{
    self = [super initWithFrame:_frame];
    if (self)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = self.bounds;
        [self addSubview:btn];
    }
    return self;
}

-(void) setVoteId:(PFObject*) vote
{
    self.vote = vote;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
