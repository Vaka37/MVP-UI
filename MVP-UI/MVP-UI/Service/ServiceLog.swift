// ServiceLog.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Действия юзера
enum LogAction {
    case userOpenRecipeScene(String)
    case userOpenRecipe(String)
    case userSharedRecipe(String)

    func log(fileURL: URL) {
        let command = LogCommand(action: self)
        LogerInvoker.shared.addLogCommand(command, fileURL: fileURL)
    }
}

/// Command
final class LogCommand {
    let action: LogAction

    init(action: LogAction) {
        self.action = action
    }

    var logMessage: String {
        switch action {
        case .userOpenRecipeScene:
            return "Пользователь открыл экран рецептов"
        case let .userOpenRecipe(title):
            return "Пользователь открыл рецепт под названием: \(title)"
        case let .userSharedRecipe(title):
            return "Пользователь поделился рецептом: \(title)"
        }
    }
}

/// Receiver
final class Logger {
    func writeMessageToLog(message: String, fileURL: URL) {
        do {
            try writeLog(message: message, fileURL: fileURL)
        } catch {
            print("не записал данные в журнал \(error.localizedDescription)")
        }
    }

    func writeLog(message: String, fileURL: URL) throws {
        let data = (message + "\n").data(using: .utf8) ?? Data()

        do {
            if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            } else {
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    try FileManager.default.removeItem(at: fileURL)
                }
                FileManager.default.createFile(atPath: fileURL.path, contents: data)
            }
        }
    }
}

/// Invoker
final class LogerInvoker {
    static let shared = LogerInvoker()

    private let logger = Logger()
    private let batchSize = 1
    private var commands: [LogCommand] = []

    func addLogCommand(_ command: LogCommand, fileURL: URL) {
        commands.append(command)
        executeCommandsIfNeeded(fileURL: fileURL)
    }

    private func executeCommandsIfNeeded(fileURL: URL) {
        guard commands.count >= batchSize else { return }
        commands.forEach { logger.writeMessageToLog(message: $0.logMessage, fileURL: fileURL) }
        commands = []
    }
}
