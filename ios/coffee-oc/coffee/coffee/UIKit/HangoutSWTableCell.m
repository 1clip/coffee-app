//
//  Hangout.m
//  coffee
//
//  Created by wang xuan on 14-12-6.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "HangoutSWTableCell.h"
#import "ViewEnums.h"
#import "UIHelper.h"
#import "HangoutHelper.h"

@implementation HangoutSWTableCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) setData:(Hangout *)hangout CurrentHangoutSummary:(HangoutSummary *)hangoutSummary UserParticipate:(Participator *) myState
{
    NSString *avator = hangoutSummary.organizer.avatarInfo.imageUrl;
    
    //Set Activity
    [self.activityImage setBackgroundColor: (hangoutSummary.state == [HangoutState Active]) ? [UIHelper GetBackgroundColorByParticateState:myState.state] : [CoffeeUIColor OverdueColor]];
    [self.activityImage setImage:[UIImage imageNamed:[UIHelper MapActiveImage:hangoutSummary.activity]]];
    
    //Set Topic view
    [self.topicLabel1 setText: hangoutSummary.subject];
    [self.topicLabel1 setTextColor:[CoffeeUIColor MainPageFontColor]];
    [self.userNameLabel setText: hangoutSummary.organizer.friendlyName];
    [self.userNameLabel setTextColor:[CoffeeUIColor MainPageFontColor]];
    [self.avatorImage setImageWithURL:nil placeholderImage:[UIImage imageNamed:avator]];
    
    //Set Participate number
    [self.acceptCount setText:[NSString stringWithFormat:@"%d", (int)hangoutSummary.numAccepted]];
    [self.pendingCount setText:[NSString stringWithFormat:@"%d", (int)hangoutSummary.numPending]];
    [self.rejectCount setText:[NSString stringWithFormat:@"%d", (int)hangoutSummary.numRejected]];

    
    //Set time and action button
    [self.schedule setText: [NSString stringWithFormat:@"%@", [UIHelper DisplayHangoutDate:hangout.startTime]]];
    
    if(hangoutSummary.state == [HangoutState Active])
    {
        [self setRightUtilityButtons:[self rightButtons: myState.state] WithButtonWidth:52];
    }
    
    [self.borderView setBackgroundColor:[CoffeeUIColor GrayBackgroundColor]];
}



- (NSArray *)rightButtons:(NSString *) participatorState
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    if(participatorState != [ParticipatorState Accept])
    {
        [rightUtilityButtons sw_addUtilityButtonWithColor: [CoffeeUIColor AcceptColor] icon:[UIImage imageNamed:@"Main_RightButton_Accept"]];
    }
    if(participatorState != [ParticipatorState Pending])
    {
        [rightUtilityButtons sw_addUtilityButtonWithColor: [CoffeeUIColor PendingColor] icon:[UIImage imageNamed:@"Main_RightButton_Pending"]];
    }
    if(participatorState != [ParticipatorState Reject])
    {
        [rightUtilityButtons sw_addUtilityButtonWithColor: [CoffeeUIColor CancelColor] icon:[UIImage imageNamed:@"Main_RightButton_Cancel"]];
    }
    [rightUtilityButtons sw_addUtilityButtonWithColor: [CoffeeUIColor OverdueColor] icon:[UIImage imageNamed:@"Main_RightButton_Delete"]];
    
    return rightUtilityButtons;
}


@end
