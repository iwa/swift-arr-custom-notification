import Foundation

func radarrMessage(eventType: String) -> String {
    var message = ""

    switch eventType {
    case "Grab":
        message =
            "<b>🟠🔍 Radarr - Movie Grabbed</b>\n\(ProcessInfo.processInfo.environment["radarr_movie_title"] ?? "")"

    case "Download":
        if ProcessInfo.processInfo.environment["radarr_isupgrade"] == "True" {
            message =
                "<b>🟠🆙 Radarr - Movie Upgraded</b>\n\(ProcessInfo.processInfo.environment["radarr_movie_title"] ?? "")"
        } else {
            message =
                "<b>🟠☑️ Radarr - Movie Downloaded</b>\n\(ProcessInfo.processInfo.environment["radarr_movie_title"] ?? "")"
        }

    case "Rename":
        message =
            "<b>🟠🛠️ Radarr - Movie Renamed</b>\n\(ProcessInfo.processInfo.environment["radarr_movie_title"] ?? "")\n\(ProcessInfo.processInfo.environment["radarr_movie_path"] ?? "")"

    case "HealthIssue":
        switch ProcessInfo.processInfo.environment["radarr_health_issue_level"] {
        case "Ok":
            message =
                "<b>🟠💚 Radarr - Health OK</b>\n\(ProcessInfo.processInfo.environment["radarr_health_issue_level"] ?? "")\n\(ProcessInfo.processInfo.environment["radarr_health_issue_message"] ?? "")"
        case "Notice":
            message =
                "<b>🟠💙 Radarr - Health Notice</b>\n\(ProcessInfo.processInfo.environment["radarr_health_issue_level"] ?? "")\n\(ProcessInfo.processInfo.environment["radarr_health_issue_message"] ?? "")"
        case "Warning":
            message =
                "<b>🟠🧡 Radarr - Health Warning</b>\n\(ProcessInfo.processInfo.environment["radarr_health_issue_level"] ?? "")\n\(ProcessInfo.processInfo.environment["radarr_health_issue_message"] ?? "")"
        case "Error":
            message =
                "<b>🟠💔 Radarr - Health Error</b>\n\(ProcessInfo.processInfo.environment["radarr_health_issue_level"] ?? "")\n\(ProcessInfo.processInfo.environment["radarr_health_issue_message"] ?? "")"
        default:
            message =
                "<b>🟠❓ Radarr - Health Unknown</b>\n\(ProcessInfo.processInfo.environment["radarr_health_issue_level"] ?? "")\n\(ProcessInfo.processInfo.environment["radarr_health_issue_message"] ?? "")"
        }

    case "ApplicationUpdate":
        message =
            "<b>🟠🔧 Radarr - Update</b>\n`\(ProcessInfo.processInfo.environment["radarr_update_previousversion"] ?? "") -> \(ProcessInfo.processInfo.environment["radarr_update_newversion"] ?? "")`\n\(ProcessInfo.processInfo.environment["radarr_update_message"] ?? "")"

    case "Test":
        message = "<b>🟠🔧 Radarr - Test</b>\nThis is a test notification."

    default:
        print("Unknown event type: \(eventType)")
        return "ERROR"
    }

    return message
}
