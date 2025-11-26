import Foundation

protocol UserStorageProtocol {
    func save(_ dto: [ScanDTO])
    func load() -> [Scan]
}
