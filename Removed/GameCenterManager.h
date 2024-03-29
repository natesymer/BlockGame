
#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@class GKLeaderboard, GKAchievement, GKPlayer;

@protocol GameCenterManagerDelegate <NSObject>
@optional
- (void)processGameCenterAuth:(NSError *)error;
- (void)scoreReported:(NSError *)error;
- (void)reloadScoresComplete:(GKLeaderboard *)leaderBoard error:(NSError *)error;
- (void)achievementSubmitted:(GKAchievement *)ach error:(NSError *)error;
- (void)achievementResetResult:(NSError *)error;
- (void)mappedPlayerIDToPlayer:(GKPlayer *)player error:(NSError *)error;
@end

@interface GameCenterManager : NSObject {
	NSMutableDictionary *earnedAchievementCache;
	id <GameCenterManagerDelegate, NSObject> __unsafe_unretained delegate;
}

// This property must be atomic to ensure that the cache is always in a viable state...
@property (strong) NSMutableDictionary *earnedAchievementCache;

@property (nonatomic, unsafe_unretained) id <GameCenterManagerDelegate> delegate;

- (void)authenticateLocalUser;

- (void)reportScore:(int64_t)score forCategory:(NSString *)category;
- (void)reloadHighScoresForCategory:(NSString *)category;

- (void)submitAchievement:(NSString *)identifier percentComplete:(double)percentComplete;
- (void)resetAchievements;

- (void)mapPlayerIDtoPlayer:(NSString *)playerID;
@end
