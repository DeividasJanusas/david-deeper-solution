import Foundation

struct ScanDTO: Decodable {
    let id: Int
    let lat: Double
    let lon: Double
    let name: String?
    let date: Date?
    let scanPoints: Int
    let mode: Int
}
