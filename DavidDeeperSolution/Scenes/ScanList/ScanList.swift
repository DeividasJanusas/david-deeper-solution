import Foundation

enum ScanList {
    enum Data {
        struct ScanModel {
            let id: Int
            let name: String
            let dateString: String
            let timeString: String
        }

        struct State {
            var scans: [ScanModel] = []
        }
    }
}
