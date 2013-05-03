//
//  JALQuestionDetailViewController.m
//  QuestionParse
//
//  Created by Lauren Shapiro on 4/21/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import "JALQuestionDetailViewController.h"

@interface JALQuestionDetailViewController ()

@end

@implementation JALQuestionDetailViewController

NSString* questionLabelText;
NSArray* answersArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // adjust UI Elements
    
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    
     [self.backButton setBackgroundImage:[UIImage imageNamed: @"backbutton.png"] forState:UIControlStateNormal];
    
    BOOL voteable = true;
    questionLabelText = [self.currquestion objectForKey:@"questionString"];
    answersArray = [self.currquestion objectForKey:@"answerOptions"];
    NSArray* myVotes = [[PFUser currentUser] objectForKey:@"MyVotes"];
    NSArray* myQuestions = [[PFUser currentUser] objectForKey:@"MyQuestions"];
    NSString *currId = self.currquestion.objectId;
    for(PFObject *vote in myVotes){
        [vote fetch];
        NSString *id = vote.objectId;
        if([id isEqualToString:currId]){
            voteable = false;
        }
    }
    if(voteable){
        for(PFObject *question in myQuestions){
            [question fetch];
            NSString *id = question.objectId;
            if([id isEqualToString:currId]){
                voteable = false;            }
        }
    }
    
    self.questionLabel.text = [self.currquestion objectForKey:@"questionString"];
    
     self.questionLabel.font = [UIFont fontWithName:@"Avenir" size:24];
    [self.questionLabel setTextColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]];
    
        for(int i =0 ; i < answersArray.count; i++){
            // fetch current object
            PFObject* answer = [answersArray objectAtIndex: i];
            [answer fetch];
            CGFloat offset = 40.0*i + 10; // used for UI elements
            CGFloat leftoffset = 0;
            
            // add voting buttons if this question has not yet been voted on
            if(voteable){
                // add a button to vote for this answer
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [button addTarget:self action:@selector(submitVote:)
                 forControlEvents:UIControlEventTouchUpInside];
                
                 [button setBackgroundImage:[UIImage imageNamed: @"votebackground.png"] forState:UIControlStateNormal];
            
                NSInteger j = i+1;
                [button setTitle:[NSString stringWithFormat:@"%i",j] forState:UIControlStateNormal];
                button.frame = CGRectMake(20.0, (163.0 + offset), 30.0, 30.0);
                [button setTitleColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]forState:UIControlStateNormal];
                [self.view addSubview: button];
            }
            
            // add vote information if question has already been voted on
            else {
                NSArray* voters = [answer objectForKey:@"Voters"];
                NSInteger numvotes = voters.count; 
                UILabel* numVotesLabel= [[UILabel alloc]initWithFrame:CGRectMake(50.0, (163.0 + offset), 20, 30.0)];
                leftoffset = 30;
                numVotesLabel.text = [NSString stringWithFormat:@"%i",numvotes];
               
                numVotesLabel.font = [UIFont fontWithName:@"Avenir" size:20];
                [numVotesLabel setBackgroundColor:[UIColor clearColor]];
                [numVotesLabel setTextColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
                [self.view addSubview: numVotesLabel];
            }
            
            // add associated answer labels
            NSString* answerText = [answer objectForKey:@"AnswerString"];
            UILabel* answerLabel = [[UILabel alloc]initWithFrame:CGRectMake((60.0 + leftoffset), (160.0 + offset), 320.0, 30.0)];
            answerLabel.text = answerText;
            [answerLabel setBackgroundColor:[UIColor clearColor]];
             answerLabel.font = [UIFont fontWithName:@"Avenir" size:20];
              [answerLabel setTextColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]];
            [self.view addSubview:answerLabel];
    }
    
    // add title according to whether or not this is a vote view
   
        UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake (60, 60, 240, 30)];
     if (voteable){
         title.text = @"Click to vote:";
     }
     else {
         title.text = @"Votes for:";
     }
        [title setBackgroundColor:[UIColor clearColor]];
        title.font = [UIFont fontWithName:@"Avenir" size:28];
          [title setTextColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]];
        [self.view addSubview:title];
    
    
	// Do any additional setup after loading the view.
}

-(IBAction) submitVote:(UIButton*) sender {
    NSInteger index = [sender.titleLabel.text integerValue];
    index = index -1; // 1-based for display
    PFObject* vote = [answersArray objectAtIndex:index];
    NSString* myId = [PFUser currentUser].objectId;
    [vote addUniqueObject:myId forKey:@"Voters"];
    PFObject* question = self.currquestion;
    [[PFUser currentUser] addUniqueObject: question forKey:@"MyVotes"];
    [vote saveInBackground];
    [[PFUser currentUser] saveInBackground];
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackButton:(id)sender {
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end
