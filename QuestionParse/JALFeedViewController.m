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

BOOL showAllQuestions = true;

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	
  }

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
   
    
    if (self)
    {
        self.parseClassName = @"Question";
        self.textKey = @"questionString";
        
        
        // add button for adding new questions to the view
        UIButton *addQuestionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [addQuestionButton addTarget:self
                              action:@selector(addQuestion:)
         forControlEvents:UIControlEventTouchDown];
        
        [addQuestionButton setTitle:@"Add Question" forState:UIControlStateNormal];
        addQuestionButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
        [self.view addSubview:addQuestionButton];
        
        // add button for logging out
        UIButton *logOut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [logOut setTitle:@"Log Out" forState:UIControlStateNormal];
        [logOut addTarget:self
                              action:@selector(logOutSession:)
                    forControlEvents:UIControlEventTouchDown];
        logOut.frame = CGRectMake(80.0, 260.0, 160.0, 40.0);
        [self.view addSubview:logOut];
        
        // add button to filter to my questions
        self.myQuestions = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.myQuestions setTitle:@"My Questions" forState:UIControlStateNormal];
        [self.myQuestions addTarget:self
                   action:@selector(toggleQuestions:)
         forControlEvents:UIControlEventTouchDown];
        self.myQuestions.frame = CGRectMake(80.0, 300.0, 160.0, 40.0);
        [self.view addSubview: self.myQuestions];
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
    detailVC.currquestion = currquestion;
    [self presentViewController:detailVC animated:YES completion:nil];
}

#pragma mark - IBAction Methods

- (IBAction)logOutSession:(id)sender {
    [PFUser logOut];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)addQuestion:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                        bundle:nil];
    JALQuestionDetailViewController *newQuestionVC =
    [storyboard instantiateViewControllerWithIdentifier:@"newQuestion"];
    
    [self presentViewController:newQuestionVC animated:YES completion:nil];
    
}

- (PFQuery *)queryForTable
{
    PFQuery* filterMyQuestions = [[PFQuery alloc]initWithClassName:@"Question"];
    
    // add constraint to query if we are restricting view to this user's questions
    if ( !showAllQuestions)
    {
        NSString* currUserId = [PFUser currentUser].objectId;
        [filterMyQuestions whereKey: @"questionUser" equalTo:currUserId];
    }
     return filterMyQuestions;
}


- (IBAction)toggleQuestions: (id)sender {
    // toggle question button text
    if (showAllQuestions)
    {
        [self.myQuestions setTitle:@"All Questions" forState:UIControlStateNormal];
    }
    
    else
    {
        [self.myQuestions setTitle:@"My Questions" forState:UIControlStateNormal];
    }
    
    // toggle show questions var and reload table data
    showAllQuestions = ! showAllQuestions;
    [self loadObjects];
}

@end

