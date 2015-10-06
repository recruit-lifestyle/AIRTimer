//
//  AIRTimer.swift
//  AIRTimer
//
//  Created by Yuki Nagai on 9/25/15.
//  Copyright © 2015 Yuki Nagai. All rights reserved.
//

import Foundation

public typealias TimerHandler = (AIRTimer) -> Void

private final class TimerActor {
    let timer: AIRTimer
    let handler: TimerHandler
    
    init(timer: AIRTimer, handler: TimerHandler) {
        self.timer = timer
        self.handler = handler
    }
    
    @objc func fire() {
        handler(timer)
    }
}

/**
Restartable NSTimer Wrapper.

> [You should not attempt to subclass NSTimer.](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSTimer_Class/)
*/
public final class AIRTimer {
    public let interval: NSTimeInterval
    public let userInfo: AnyObject?
    public let repeats: Bool
    private let handler: TimerHandler
    private var timer: NSTimer?
    
    public var valid: Bool {
        return timer?.valid ?? false
    }
    
    public class func after(interval: NSTimeInterval, userInfo: AnyObject? = nil, handler: TimerHandler) -> AIRTimer {
        let air = AIRTimer(timerInterval: interval, userInfo: userInfo, repeats: false, handler: handler)
        return air
    }

    public class func every(interval: NSTimeInterval, userInfo: AnyObject? = nil, handler: TimerHandler) -> AIRTimer {
        let air = AIRTimer(timerInterval: interval, userInfo: userInfo, repeats: true, handler: handler)
        return air
    }
    
    /**
    Restart timer with current interval.
    
    - return: Regenerated AIRTimer. Your property should reference this.
    */
    public func restart() {
        invalidate()
        self.timer = scheduledTimer()
    }
    
    /**
    Stops the receiver from ever firing again and requests its removal from its run loop.
    */
    public func invalidate() {
        timer?.invalidate()
        timer = nil
    }
    
    private init(timerInterval interval: NSTimeInterval, userInfo: AnyObject?, repeats: Bool, handler: TimerHandler) {
        self.interval = interval
        self.userInfo = userInfo
        self.repeats = repeats
        self.handler = handler
        self.timer = scheduledTimer()
    }
    
    private func scheduledTimer() -> NSTimer {
        let actor = TimerActor(timer: self, handler: self.handler)
        return NSTimer.scheduledTimerWithTimeInterval(
            self.interval,
            target: actor,
            selector: "fire",
            userInfo: self.userInfo,
            repeats: self.repeats)
    }
}
