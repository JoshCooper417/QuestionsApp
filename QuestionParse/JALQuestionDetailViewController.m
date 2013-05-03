//
//  JALQuestionDetailViewController.m
//  QuestionParse
//
//  Created by Lauren Shapiro on 4/21/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import "JALQuestionDetailViewController.h"
#import "JALVoteButton.h"

@interface JALQuestionDetailViewController ()

@end

@implementation JALQuestionDetailViewController

NSString* questionLabelText;
NSArray* answersArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
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
            
                NSInteger j = i+1;
                [button setTitle:[NSString stringWithFormat:@"%i",j] forState:UIControlStateNormal];
                button.frame = CGRectMake(20.0, (160.0 + offset), 40.0, 40.0);
                [self.view addSubview: button];
            }
            
            // add vote information if question has already been voted on
            else {
                NSArray* voters = [answer objectForKey:@"Voters"];
                NSInteger numvotes = voters.count; 
                UILabel* numVotesLabel= [[UILabel alloc]initWithFrame:CGRectMake(50.0, (160.0 + offset), 20, 30.0)];
                leftoffset = 30;
                numVotesLabel.text = [NSString stringWithFormat:@"%i",numvotes];
                [self.view addSubview: numVotesLabel];
            }
            
            // add associated answer labels
            NSString* answerText = [answer objectForKey:@"AnswerString"];
            UILabel* answerLabel = [[UILabel alloc]initWithFrame:CGRectMake((60.0 + leftoffset), (160.0 + offset), 120.0, 30.0)];
            answerLabel.text = answerText;
          
            [self.view addSubview:answerLabel];
    }


	// Do any additional setup after loading the view.
}

-(IBAction) submitVote:(UIButton*) sender {
    NSInteger index = [sender.titleLabel.text integerValue];
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
