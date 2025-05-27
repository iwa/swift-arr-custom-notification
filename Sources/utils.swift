import AsyncHTTPClient
import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

// Function to send message via Telegram
@available(macOS 12.0, *)
func sendTelegramMessage(message: String) async throws {
    guard let telegramChatId = ProcessInfo.processInfo.environment["TELEGRAM_CHAT_ID"] else {
        print("TELEGRAM_CHAT_ID environment variable not set")
        return
    }

    guard let telegramBotToken = ProcessInfo.processInfo.environment["TELEGRAM_BOT_TOKEN"] else {
        print("TELEGRAM_BOT_TOKEN environment variable not set")
        return
    }

    print("Telegram chat id:", telegramChatId)

    let payload = TelegramMessage(
        chatId: telegramChatId,
        text: message,
        parseMode: "HTML",
        disableNotification: true,
        protectContent: false
    )

    let jsonData = try JSONEncoder().encode(payload)

    // 2. Create the URL
    // guard let url = URL(string: "https://api.telegram.org/bot\(telegramBotToken)/sendMessage")
    // else {
    //     fatalError("Invalid URL")
    // }

    var request = HTTPClientRequest(
        url: "https://api.telegram.org/bot\(telegramBotToken)/sendMessage")
    request.method = .POST
    request.headers.add(name: "Content-Type", value: "application/json")
    request.body = .bytes(jsonData)

    // 3. Create the request
    // var request = URLRequest(url: url)
    // request.httpMethod = "POST"
    // request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    // request.httpBody = jsonData

    let response = try await HTTPClient.shared.execute(request, timeout: .seconds(10))
    if response.status == .ok {
        // handle response
        print("Status code from Telegram API:", response.status.code)
    } else {
        // handle remote error
        print("Async request failed:", response.status.description)
    }

    // do {
    //     let (_, response) = try await URLSession.shared.data(for: request)
    //     if let httpResponse = response as? HTTPURLResponse {
    //         print("Status code from Telegram API:", httpResponse.statusCode)
    //     }
    // } catch {
    //     print("Async request failed:", error)
    // }
}

// Function to format episodes
func formatEpisodes(seasonNumber: String, episodeNumbers: String, episodeTitles: String) throws
    -> String
{
    let numbers = episodeNumbers.components(separatedBy: ",")
    let titles = episodeTitles.components(separatedBy: "|")

    guard numbers.count == titles.count else {
        throw NSError(
            domain: "FormatError", code: 1,
            userInfo: [NSLocalizedDescriptionKey: "Mismatch between episode numbers and titles"])
    }

    var formattedEpisodes = ""

    for (index, numberStr) in numbers.enumerated() {
        guard let num = Int(numberStr.trimmingCharacters(in: .whitespacesAndNewlines)) else {
            throw NSError(
                domain: "FormatError", code: 2,
                userInfo: [NSLocalizedDescriptionKey: "Failed to convert episode number to int"])
        }

        if index != 0 {
            formattedEpisodes += "\n"
        }

        formattedEpisodes +=
            "<code>\(seasonNumber)x\(String(format: "%02d", num))</code> - \(titles[index])"
    }

    return formattedEpisodes
}
