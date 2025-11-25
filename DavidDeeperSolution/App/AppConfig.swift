import Foundation

enum AppConfig {
    static let baseURL = URL(string: "https://bathus.staging.deeper.eu/api/")!
    static let bundleIdentifier = Bundle.main.bundleIdentifier ?? "com.task.DavidDeeperSolution"
}
