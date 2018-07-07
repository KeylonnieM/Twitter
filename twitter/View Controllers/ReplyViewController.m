//
//  ReplyViewController.m
//  twitter
//
//  Created by Keylonnie Miller on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ReplyViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TweetViewController.h"


@interface ReplyViewController ()
@property (weak, nonatomic) IBOutlet UITextView *replyText;
@property (weak, nonatomic) IBOutlet UILabel *characterCountLabel;

@end

@implementation ReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.replyText.delegate = self;
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeViewController:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}



- (IBAction)tweetReplyText:(id)sender {
    //NSString *text = self.replyText.text;
    [[APIManager shared] postReply:self.tweet withText:self.replyText.text completion:(^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error replying to Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didReply:tweet];
            NSLog(@"Replied to Tweet Successfully!");
        }
        
    })];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // Set the max character limit
    int characterLimit = 141;
    
    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.replyText.text stringByReplacingCharactersInRange:range withString:text];
    
    // TODO: Update Character Count Label
    //NSUInteger *counted = self.composeText.text.length ;
    NSUInteger *remaining = 140 - self.replyText.text.length;
    self.characterCountLabel.text = [NSString stringWithFormat:@"Character Count: %i", remaining];
    // The new text should be allowed? True/False
    return newText.length < characterLimit;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
