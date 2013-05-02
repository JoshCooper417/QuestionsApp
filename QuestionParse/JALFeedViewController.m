//
//  JALFeedViewController.m
//  QuestionParse
//
//  Created by Lauren Shapiro on 4/21/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import "JALFeedViewController.h"
#import "JALQuestionDetailViewController.h"
#import "JALNewQuestionViewController.h"

@implementation JALFeedViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.parseClassName = @"Question";
        UIButton *addQuestionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [addQuestionButton addTarget:self
                              action:@selector(addQuestion:)
         forControlEvents:UIControlEventTouchDown];
        [addQuestionButton setTitle:@"Add Question" forState:UIControlStateNormal];
        addQuestionButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
        [self.view addSubview:addQuestionButton];
        
    }
    return self;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self pushDetailView];
}

- (IBAction)pushDetailView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                         bundle:nil];
    JALQuestionDetailViewController *detailVC =
    [storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    
    NSIndexPath* currpath = [[NSIndexPath alloc]init];
    currpath = self.tableView.indexPathForSelectedRow;
    
    PFObject* currquestion = [self objectAtIndexPath:currpath];
    NSString* question = [currquestion objectForKey:@"questionString"];

    [detailVC setQuestionLabelText: question];
    [self presentViewController:detailVC animated:YES completion:nil];
}

- (IBAction)addQuestion:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                        bundle:nil];
    JALQuestionDetailViewController *newQuestionVC =
    [storyboard instantiateViewControllerWithIdentifier:@"newQuestion"];
    
    [self presentViewController:newQuestionVC animated:YES completion:nil];
    
}
@end

