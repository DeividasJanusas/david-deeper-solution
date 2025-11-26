import Foundation

final class UserDefaultsStorage: UserStorageProtocol {
    private let key = AppConfig.bundleIdentifier + ".scans"

    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    func save(_ dto: [ScanDTO]) {
        if let data = try? encoder.encode(dto) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func load() -> [Scan] {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let dto = try? decoder.decode([ScanDTO].self, from: data)
        else {
            return []
        }

        return dto.map { $0.toDomain() }
    }
}
