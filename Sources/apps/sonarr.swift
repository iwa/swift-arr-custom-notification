import Foundation

func sonarrMessage(eventType: String) -> String {
    var message = ""

    do {
        switch eventType {
        case "Grab":
            let formattedEpisodes = try formatEpisodes(
                seasonNumber: ProcessInfo.processInfo.environment["sonarr_release_seasonnumber"]
                    ?? "",
                episodeNumbers: ProcessInfo.processInfo.environment[
                    "sonarr_release_episodenumbers"]
                    ?? "",
                episodeTitles: ProcessInfo.processInfo.environment[
                    "sonarr_release_episodetitles"]
                    ?? ""
            )
            message =
                "<b>🔵🔍 Sonarr - Episode Grabbed</b>\n\(ProcessInfo.processInfo.environment["sonarr_series_title"] ?? "")\n\(formattedEpisodes)"

        case "Download":
            let formattedEpisodes = try formatEpisodes(
                seasonNumber: ProcessInfo.processInfo.environment[
                    "sonarr_episodefile_seasonnumber"]
                    ?? "",
                episodeNumbers: ProcessInfo.processInfo.environment[
                    "sonarr_episodefile_episodenumbers"] ?? "",
                episodeTitles: ProcessInfo.processInfo.environment[
                    "sonarr_episodefile_episodetitles"] ?? ""
            )
            if ProcessInfo.processInfo.environment["sonarr_isupgrade"] == "True" {
                message =
                    "<b>🔵🆙 Sonarr - Episode Upgraded</b>\n\(ProcessInfo.processInfo.environment["sonarr_series_title"] ?? "")\n\(formattedEpisodes)"
            } else {
                message =
                    "<b>🔵☑️ Sonarr - Episode Downloaded</b>\n\(ProcessInfo.processInfo.environment["sonarr_series_title"] ?? "")\n\(formattedEpisodes)"
            }

        case "Rename":
            message =
                "<b>🔵🛠️ Sonarr - Episode Renamed</b>\n\(ProcessInfo.processInfo.environment["sonarr_series_title"] ?? "")\n`\(ProcessInfo.processInfo.environment["sonarr_series_path"] ?? "")`"

        case "EpisodeFileDelete":
            let formattedEpisodes = try formatEpisodes(
                seasonNumber: ProcessInfo.processInfo.environment[
                    "sonarr_episodefile_seasonnumber"]
                    ?? "",
                episodeNumbers: ProcessInfo.processInfo.environment[
                    "sonarr_episodefile_episodenumbers"] ?? "",
                episodeTitles: ProcessInfo.processInfo.environment[
                    "sonarr_episodefile_episodetitles"] ?? ""
            )
            message =
                "<b>🔵🗑️ Sonarr - Episode Deleted</b>\n\(ProcessInfo.processInfo.environment["sonarr_series_title"] ?? "")\n\(formattedEpisodes)"

        case "SeriesDelete":
            message =
                "<b>🔵🗑️ Sonarr - Serie Deleted</b>\n\(ProcessInfo.processInfo.environment["sonarr_series_title"] ?? "")\n`\(ProcessInfo.processInfo.environment["sonarr_series_path"] ?? "")`"

        case "HealthIssue":
            switch ProcessInfo.processInfo.environment["sonarr_health_issue_level"] {
            case "Ok":
                message =
                    "<b>🔵💚 Sonarr - Health OK</b>\n\(ProcessInfo.processInfo.environment["sonarr_health_issue_type"] ?? "")\n\(ProcessInfo.processInfo.environment["sonarr_health_issue_message"] ?? "")"
            case "Notice":
                message =
                    "<b>🔵💙 Sonarr - Health Notice</b>\n\(ProcessInfo.processInfo.environment["sonarr_health_issue_type"] ?? "")\n\(ProcessInfo.processInfo.environment["sonarr_health_issue_message"] ?? "")"
            case "Warning":
                message =
                    "<b>🔵🧡 Sonarr - Health Warning</b>\n\(ProcessInfo.processInfo.environment["sonarr_health_issue_type"] ?? "")\n\(ProcessInfo.processInfo.environment["sonarr_health_issue_message"] ?? "")"
            case "Error":
                message =
                    "<b>🔵💔 Sonarr - Health Error</b>\n\(ProcessInfo.processInfo.environment["sonarr_health_issue_type"] ?? "")\n\(ProcessInfo.processInfo.environment["sonarr_health_issue_message"] ?? "")"
            default:
                message =
                    "<b>🔵❓ Sonarr - Health Unknown</b>\n\(ProcessInfo.processInfo.environment["sonarr_health_issue_type"] ?? "")\n\(ProcessInfo.processInfo.environment["sonarr_health_issue_message"] ?? "")"
            }

        case "ApplicationUpdate":
            message =
                "<b>🔵🔧 Sonarr - Update</b>\n`\(ProcessInfo.processInfo.environment["sonarr_update_previousversion"] ?? "") -> \(ProcessInfo.processInfo.environment["sonarr_update_newversion"] ?? "")`\n\(ProcessInfo.processInfo.environment["sonarr_update_message"] ?? "")"

        case "Test":
            message = "<b>🔵🔧 Sonarr - Test</b>\nThis is a test notification."

        default:
            print("Unknown event type: \(eventType)")
            return "ERROR"
        }
    } catch {
        print("Error formatting episodes:", error)
        return "ERROR"
    }

    return message
}
