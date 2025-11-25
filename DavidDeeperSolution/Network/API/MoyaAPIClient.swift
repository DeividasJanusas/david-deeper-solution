import Foundation
import Moya

final class MoyaAPIClient: APIClient {
    private let provider: MoyaProvider<BackendEndpoint>
    private let decoder: JSONDecoder

    init(decoder: JSONDecoder = .withAPIDefaultsStringDates()) {
        provider = MoyaProvider<BackendEndpoint>(
            plugins: [
                NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
            ]
        )
        self.decoder = decoder
    }

    func request<T: Decodable>(_ target: BackendEndpoint) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(target) { result in

                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)

                case .success(let response):
                    guard (200...299).contains(response.statusCode) else {
                        continuation.resume(
                            throwing: APIError.server(
                                status: response.statusCode,
                                message: String(data: response.data, encoding: .utf8)
                            )
                        )
                        return
                    }

                    do {
                        let value = try self.decoder.decode(T.self, from: response.data)
                        continuation.resume(returning: value)
                    } catch {
                        continuation.resume(
                            throwing: APIError.decoding(error.localizedDescription)
                        )
                    }
                }
            }
        }
    }
}
