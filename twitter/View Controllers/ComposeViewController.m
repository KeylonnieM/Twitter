//
//  ComposeViewController.m
//  twitter
//
//  Created by Keylonnie Miller on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TimelineViewController.h"
#import "User.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *composeText;
@property (strong,nonatomic) NSMutableArray *composedTweetFeed;
@property (weak, nonatomic) IBOutlet UILabel *characterCountLabel;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.composeText.delegate = self;
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeViewController:(id)sender {
[self dismissViewControllerAnimated:true completion:nil];
}



- (IBAction)tweetComposedText:(id)sender {
    NSString *text = self.composeText.text;
    [[APIManager shared] postStatusWithText:(NSString *)text completion:(^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
        [self dismissModalViewControllerAnimated:YES];
    })];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // Set the max character limit
    int characterLimit = 141;
    
    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.composeText.text stringByReplacingCharactersInRange:range withString:text];
    
    // TODO: Update Character Count Label
    //NSUInteger *counted = self.composeText.text.length ;
    NSUInteger *remaining = 140 - self.composeText.text.length;
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
