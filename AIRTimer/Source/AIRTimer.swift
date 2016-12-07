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
    
    init(timer: AIRTimer, handler: @escaping TimerHandler) {
        self.timer = timer
        self.handler = handler
    }
    
    @objc
    func fire() {
        handler(timer)
    }
}

/**
Restartable NSTimer Wrapper.

> [You should not attempt to subclass NSTimer.](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSTimer_Class/)
*/
public final class AIRTimer {
    public let timerInterval: TimeInterval
    public let userInfo: Any?
    public let repeats: Bool
    private let handler: TimerHandler
    private var timer: Timer?
    
    public var isValid: Bool {
        return timer?.isValid ?? false
    }
    
    public static func after(
        _ timerInterval: TimeInterval,
        userInfo: Any? = nil,
        handler: @escaping TimerHandler) -> AIRTimer {
        let air = AIRTimer(timerInterval: timerInterval, userInfo: userInfo, repeats: false, handler: handler)
        return air
    }

    public static func every(
        _ timerInterval: TimeInterval,
        userInfo: Any? = nil,
        handler: @escaping TimerHandler) -> AIRTimer {
        let air = AIRTimer(timerInterval: timerInterval, userInfo: userInfo, repeats: true, handler: handler)
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
    
    private init(
        timerInterval: TimeInterval,
        userInfo: Any?,
        repeats: Bool,
        handler: @escaping TimerHandler) {
        self.timerInterval = timerInterval
        self.userInfo = userInfo
        self.repeats = repeats
        self.handler = handler
        self.timer = scheduledTimer()
    }
    
    private func scheduledTimer() -> Timer {
        let actor = TimerActor(timer: self, handler: self.handler)
        return Timer.scheduledTimer(
            timeInterval: self.timerInterval,
            target: actor,
            selector: #selector(TimerActor.fire),
            userInfo: self.userInfo,
            repeats: self.repeats)
    }
}
