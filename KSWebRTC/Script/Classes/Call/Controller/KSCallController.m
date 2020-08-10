//
//  KSCallController.m
//  KSWebRTC
//
//  Created by saeipi on 2020/8/8.
//  Copyright © 2020 saeipi. All rights reserved.
//

#import "KSCallController.h"
#import "KSCallView.h"
#import <WebRTC/RTCAudioSession.h>
#import "KSMessageHandler.h"
#import "KSMediaCapture.h"
#import "KSMsg.h"
#import "UIButton+Category.h"

@interface KSCallController ()<KSVideoCallViewDelegate,KSMessageHandlerDelegate>

@property(nonatomic, weak) KSCallView *callView;
@property (nonatomic, strong) KSMessageHandler *msgHandler;
@property (nonatomic, strong) KSMediaCapture *mediaCapture;
@property (nonatomic, assign) BOOL isConnect;

@end

@implementation KSCallController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initKit];
    [self initProperty];
}

- (void)initProperty {
    _mediaCapture = [[KSMediaCapture alloc] init];
    [_mediaCapture createPeerConnectionFactory];
    AVCaptureSession *captureSession = [_mediaCapture captureLocalMedia];
    
    [_callView setLocalViewSession:captureSession];
    
    _msgHandler = [[KSMessageHandler alloc] init];
    _msgHandler.delegate = self;
}

- (void)initKit {
    KSTileLayout *layout            = [[KSTileLayout alloc] init];
    layout.scale                    = KSScaleMake(9, 16);
    layout.mode                     = KSContentModeScaleAspectFit;
    int width                       = 96;
    int height                      = width / layout.scale.width * layout.scale.height;
    layout.layout                   = KSLayoutMake(width, height, 10, 10);

    KSCallView *callView            = [[KSCallView alloc] initWithFrame:self.view.bounds layout:layout callType:KSCallTypeManyVideo];
    callView.delegate               = self;
    _callView                       = callView;
    [callView createLocalViewWithLayout:layout resizingMode:KSResizingModeScreen callType:KSCallTypeSingleVideo];
    [self.view addSubview:callView];

    UIButton *arrowBtn              = [UIButton ks_buttonWithNormalImg:@"icon_bar_double_arrow_white"];
    arrowBtn.frame                  = CGRectMake(0, 0, KS_Extern_Point24, KS_Extern_Point24);
    [arrowBtn addTarget:self action:@selector(onArrowClick) forControlEvents:UIControlEventTouchUpInside];
    self.superBar.backBarButtonItem = arrowBtn;
    [self.superBar toFront];
}

- (void)onArrowClick {
    [self pop];
}
//KSMessageHandlerDelegate
- (void)messageHandler:(KSMessageHandler *)messageHandler didReceivedMessage:(KSMsg *)message {
    
}

- (void)messageHandler:(KSMessageHandler *)messageHandler detached:(KSDetached *)detached {
    [_callView leaveOfHandleId:detached.sender];
}

- (KSMediaCapture *)mediaCaptureOfSectionsInMessageHandler:(KSMessageHandler *)messageHandler {
    return _mediaCapture;
}

- (RTCEAGLVideoView *)remoteViewOfSectionsInMessageHandler:(KSMessageHandler *)messageHandler handleId:(NSNumber *)handleId {
    return [_callView remoteViewOfHandleId:handleId];
}


//KSVideoCallViewDelegate
- (void)videoCallViewDidChangeRoute:(KSCallView *)view {
    
}

- (void)videoCallViewDidEnableStats:(KSCallView *)view {
    
}

- (void)videoCallViewDidHangup:(KSCallView *)view {
    
}

- (void)videoCallViewDidSwitchCamera:(KSCallView *)view {
    
}

//KSMessageHandlerDelegate
- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    return CGSizeZero;
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    
}

- (void)setNeedsFocusUpdate {
    
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    return YES;
}

- (void)updateFocusIfNeeded {
    
}
@end
