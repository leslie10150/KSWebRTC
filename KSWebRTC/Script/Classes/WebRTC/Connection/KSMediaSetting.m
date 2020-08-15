//
//  KSMediaSetting.m
//  KSWebRTC
//
//  Created by saeipi on 2020/8/15.
//  Copyright © 2020 saeipi. All rights reserved.
//

#import "KSMediaSetting.h"

@implementation KSIceServer
- (id)copyWithZone:(nullable NSZone *)zone {
    KSIceServer *iceServer = [[KSIceServer alloc] init];
    iceServer.servers      = [_servers copy];
    iceServer.username     = _username;
    iceServer.password     = _password;
    return iceServer;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    KSIceServer *iceServer = [[KSIceServer alloc] init];
    iceServer.servers      = [_servers mutableCopy];
    iceServer.username     = _username;
    iceServer.password     = _password;
    return iceServer;
}
- (instancetype)init {
    if (self = [super init]) {
        _servers = [NSMutableArray arrayWithObject:@"turn:turn.al.mancangyun:3478"];
        _username = @"root";
        _password = @"mypasswd";
    }
    return self;
}
@end

@implementation KSCapturerSetting
-(instancetype)init {
    if (self = [super init]) {
        _isSSL          = NO;
        _isFront        = YES;
        _isOpenSpeaker  = YES;
        _isMuteAudio    = NO;
        _isMuteVideo    = NO;
        _isStartCapture = YES;
        _resolution     = CGSizeMake(540, 960);
    }
    return self;
}
@end

@implementation KSConnectionSetting

-(instancetype)init {
    if (self = [super init]) {
        _audio = YES;
        _video = YES;
        
    }
    return self;
}
- (void)setCallType:(KSCallType)callType {
    _callType = callType;
}

- (BOOL)isFocus {
    if (_callType == KSCallTypeManyVideo || _callType == KSCallTypeSingleVideo) {
        return YES;
    }
    return NO;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    KSConnectionSetting *setting = [[KSConnectionSetting alloc] init];
    setting.iceServer            = [_iceServer copy];
    setting.callType             = _callType;
    setting.audio                = _audio;
    setting.video                = _video;
    return setting;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    KSConnectionSetting *setting = [[KSConnectionSetting alloc] init];
    setting.iceServer            = [_iceServer copy];
    setting.callType             = _callType;
    setting.audio                = _audio;
    setting.video                = _video;
    return setting;
}
@end

@implementation KSMediaSetting
-(instancetype)initWithConnectionSetting:(KSConnectionSetting *)connectionSetting capturerSetting:(KSCapturerSetting *)capturerSetting {
    if (self = [super init]) {
        _connectionSetting = connectionSetting;
        _capturerSetting   = capturerSetting;
        _callType          = connectionSetting.callType;
    }
    return self;
}
@end

