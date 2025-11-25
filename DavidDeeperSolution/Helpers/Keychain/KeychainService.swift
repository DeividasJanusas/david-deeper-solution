import Foundation
import KeychainAccess

final class KeychainService {
    private let keychain: Keychain
    private let tokenKey = "authToken"

    var token: String? {
        get {
            try? keychain.get(tokenKey)
        }
        set {
            if let value = newValue {
                try? keychain.set(value, key: tokenKey)
            } else {
                try? keychain.remove(tokenKey)
            }
        }
    }

    init(service: String = AppConfig.bundleIdentifier) {
        self.keychain = Keychain(service: service)
            .accessibility(.afterFirstUnlock)
    }
}

