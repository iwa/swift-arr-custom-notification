import Foundation

@available(macOS 12.0, *)
func main() async {
    let sonarrEventType = ProcessInfo.processInfo.environment["sonarr_eventtype"] ?? nil
    let radarrEventType = ProcessInfo.processInfo.environment["radarr_eventtype"] ?? nil

    var message = ""

    if sonarrEventType != nil {
        print("Sonarr - Event type:", sonarrEventType!)
        message = sonarrMessage(eventType: sonarrEventType!)
    } else if radarrEventType != nil {
        print("Radarr - Event type:", radarrEventType!)
        message = radarrMessage(eventType: radarrEventType!)
    } else {
        print("No event type found")
        return
    }

    if message.isEmpty {
        print("No message to send")
        return
    }

    do {
        try await sendTelegramMessage(message: message)
    } catch {
        print("Error sending message:", error)
    }
}

if #available(macOS 12.0, *) {
    await main()
} else {
    fatalError("macOS 12.0 or later is required.")
}
