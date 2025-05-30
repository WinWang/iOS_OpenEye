//
//  LogUtils.swift
//  iOS_OpenEye
//
//  打印日志全局函数
//
//  Created by WinWang on 2025/5/30.
//
import CocoaLumberjackSwift

func logDebug(_ msg: String? = nil, tag: String? = nil) {
    if let msg = msg {
        DDLogDebug(msg)
    }
}

func logWarn(_ msg: String? = nil, tag: String? = nil) {
    if let msg = msg {
        DDLogWarn(msg)
    }
}

func logError(_ msg: String? = nil, tag: String? = nil) {
    if let msg = msg {
        DDLogError(msg)
    }
}

// 初始化log
func initLogger() {
    DDLog.add(DDOSLogger.sharedInstance) // Uses os_log
    let fileLogger = DDFileLogger() // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7
    DDLog.add(fileLogger)
}
