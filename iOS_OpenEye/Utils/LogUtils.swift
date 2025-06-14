//
//  LogUtils.swift
//  iOS_OpenEye
//
//  打印日志全局函数
//
//  Created by WinWang on 2025/5/30.
//
import CocoaLumberjackSwift

let LOG_CONTEXT = 10000

func logDebug(_ msg: String? = nil, tag: String? = nil) {
    if let msg = msg {
        DDLogDebug("\(msg)", level: .debug, context: LOG_CONTEXT, tag: tag)
    }
}

func logWarn(_ msg: String? = nil, tag: String? = nil) {
    if let msg = msg {
        DDLogWarn("\(msg)", level: .warning, context: LOG_CONTEXT, tag: tag)
    }
}

func logInfo(_ msg: String? = nil, tag: String? = nil) {
    if let msg = msg {
        DDLogInfo("\(msg)", level: .warning, context: LOG_CONTEXT, tag: tag)
    }
}

func logError(_ msg: String? = nil, tag: String? = nil) {
    if let msg = msg {
        DDLogError("\(msg)", level: .error, context: LOG_CONTEXT, tag: tag)
    }
}

// 打印json数据
func logJSON(_ json: Any, level: DDLogLevel = .debug, tag: String? = nil) {
    let formattedJSON = formatJSON(json)
    switch level {
    case .debug:
        logDebug(formattedJSON, tag: tag)
    case .warning:
        logWarn(formattedJSON, tag: tag)
    case .error:
        logError(formattedJSON, tag: tag)
    default:
        logInfo(formattedJSON, tag: tag)
    }
}

/**
 *网络日志打印
 */
func logHttp(_ msg: String? = nil) {
    logDebug(msg, tag: "[_http]")
}

// 初始化log
func initLogger() {
    DDLog.add(DDOSLogger.sharedInstance) // Uses os_log
    let fileLogger = DDFileLogger() // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7
    DDLog.add(fileLogger)
}
