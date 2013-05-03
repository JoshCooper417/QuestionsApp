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
    //Now we know we haven't voted for it and it's not our question, so we can vote
    //Add the buttons
    if(voteable){
        for(int i =0 ; i < answersArray.count; i++){
            PFObject* answer = [answersArray objectAtIndex: i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
             [button addTarget:self
                        action:@selector(submitVote:)
              forControlEvents:UIControlEventTouchUpInside];
            NSInteger j = i+1;
             [button setTitle:[NSString stringWithFormat:@"%i",j] forState:UIControlStateNormal];
            CGFloat offset = 40.0*i;
             button.frame = CGRectMake(80.0, (210.0 + offset), 160.0, 40.0);
             [self.view addSubview: button];
         }
    
    }
     self.questionLabel.text = questionLabelText;
    NSMutableString* ansText = [[NSMutableString alloc] init];
    for(PFObject* answer in answersArray){
        [answer fetch];
        NSString *answerString = [answer objectForKey:@"AnswerString"];
        [ansText appendString:answerString];
    }
    self.answers.text=ansText;
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
