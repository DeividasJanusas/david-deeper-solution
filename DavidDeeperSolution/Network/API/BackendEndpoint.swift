import Foundation
import Moya

public enum BackendEndpoint {
    case login(email: String, password: String)
    case getGeoData(scanId: Int, token: String)
}

extension BackendEndpoint: TargetType {
    public var baseURL: URL { AppConfig.baseURL }

    public var path: String {
        switch self {
        case .login: return "login"
        case .getGeoData: return "geoData"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login: .post
        case .getGeoData: .get
        }
    }

    public var task: Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(
                parameters: ["email": email, "password": password],
                encoding: JSONEncoding.default
            )

        case let .getGeoData(scanId, token):
            let params: [String: Any] = [
                "grid": "FAST",
                "generator": "BS",
                "scanIds": scanId,
                "token": token
            ]

            return .requestParameters(
                parameters: params,
                encoding: URLEncoding.queryString
            )
        }
    }

    public var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
}
