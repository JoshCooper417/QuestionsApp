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
        
        // adjust size of table view
        CGRect tableviewrect= CGRectMake(0,50,320,200);
        [self.tableView setFrame:tableviewrect];
        
        // create frame for footer
        UIView* footer = [[UIView alloc]initWithFrame:CGRectMake(0, 250, 320, 100)];
        self.tableView.tableFooterView = footer;
        
        UIView* header = [[UIView alloc]initWithFrame:CGRectMake(80,0,320,40)];
        
        UIImageView* logo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"smalllogo.png"]];
        [header addSubview:logo];
        self.tableView.tableHeaderView = header;
        
        // add button for adding new questions to the view
        UIButton *addQuestionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [addQuestionButton addTarget:self
                              action:@selector(addQuestion:)
         forControlEvents:UIControlEventTouchDown];
        [addQuestionButton setBackgroundImage:[UIImage imageNamed: @"addquestion.png"] forState:UIControlStateNormal];
       
        addQuestionButton.frame = CGRectMake(80.0, 20.0, 160.0, 40.0);
        
        
        
        [self.tableView.tableFooterView addSubview:addQuestionButton];
        
        // add button for logging out
        UIButton *logOut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [logOut setBackgroundImage:[UIImage imageNamed: @"logout.png"] forState:UIControlStateNormal];
        
        [logOut addTarget:self
                              action:@selector(logOutSession:)
                    forControlEvents:UIControlEventTouchDown];
        logOut.frame = CGRectMake(80.0, 70.0, 160.0, 40.0);
            [self.tableView.tableFooterView addSubview:logOut];
        
        // add button to filter to my questions
        self.myQuestions = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.myQuestions setBackgroundImage:[UIImage imageNamed: @"myquestions.png"] forState:UIControlStateNormal];
        [self.myQuestions addTarget:self
                   action:@selector(toggleQuestions:)
         forControlEvents:UIControlEventTouchDown];
        self.myQuestions.frame = CGRectMake(80.0, 120, 160.0, 40.0);

//        self.myQuestions.frame = CGRectMake(80.0, 70.0, 160.0, 40.0);
        [self.tableView.tableFooterView addSubview:self.myQuestions];
        
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


- (IBAction)toggleQuestions: (id)sender {
    // toggle question button text
    if (showAllQuestions)
    {
         [self.myQuestions setBackgroundImage:[UIImage imageNamed: @"allquestions.png"] forState:UIControlStateNormal];
    }
    
    else
    {
        [self.myQuestions setBackgroundImage:[UIImage imageNamed: @"myquestions.png"] forState:UIControlStateNormal];
    }
    
    // toggle show questions var and reload table data
    showAllQuestions = ! showAllQuestions;
    [self loadObjects];
}

#pragma mark - Overridden PFQueryTableViewController methods

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


//- (PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
//
//{
//    static NSString* CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc]init];
//    }
//    
//    cell.textLabel.text = [object objectForKey:@"questionString"];
//    cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:20];
//    
//    cell.textLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
//    
//    return cell;
//}

@end

