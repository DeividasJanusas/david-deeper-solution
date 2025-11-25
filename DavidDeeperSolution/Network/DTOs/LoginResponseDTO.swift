import Foundation

struct LoginResponseDTO: Decodable {
    let login: LoginDataDTO
    let scans: [ScanDTO]
}

struct LoginDataDTO: Decodable {
    let appId: String?
    let token: String
    let userId: Int
    let validated: Bool
    let validTill: Date?
    let registrationDate: Date?
}
