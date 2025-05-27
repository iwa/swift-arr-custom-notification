import Foundation

// Create a convenient Constants struct that uses the loaded env vars
struct Constants {
    static let telegramBotToken = ProcessInfo.processInfo.environment["TELEGRAM_BOT_TOKEN"] ?? ""
    static let telegramChatId = ProcessInfo.processInfo.environment["TELEGRAM_CHAT_ID"] ?? ""
}

struct TelegramMessage: Codable {
    let chatId: String
    let text: String
    let parseMode: String
    let disableNotification: Bool
    let protectContent: Bool

    enum CodingKeys: String, CodingKey {
        case chatId = "chat_id"
        case text
        case parseMode = "parse_mode"
        case disableNotification = "disable_notification"
        case protectContent = "protect_content"
    }
}