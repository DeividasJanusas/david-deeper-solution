import Foundation

struct ScanDTO: Codable {
    let id: Int
    let lat: Double
    let lon: Double
    let name: String?
    let date: Date?
    let scanPoints: Int
    let mode: Int
}

extension ScanDTO {
    func toDomain() -> Scan {
        Scan(
            id: id,
            lat: lat,
            lon: lon,
            name: name,
            date: date,
            scanPoints: scanPoints
        )
    }
}
