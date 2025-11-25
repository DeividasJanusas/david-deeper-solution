import Foundation

public protocol APIClient {
    func request<T: Decodable>(_ target: BackendEndpoint) async throws -> T
}
