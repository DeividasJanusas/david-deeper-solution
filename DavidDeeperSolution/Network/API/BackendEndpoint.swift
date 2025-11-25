import Foundation
import Moya

public enum BackendEndpoint {
    case login(email: String, password: String)
}

extension BackendEndpoint: TargetType {
    public var baseURL: URL { AppConfig.baseURL }

    public var path: String {
        switch self {
        case .login: return "login"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login: .post
        default: .get
        }
    }

    public var task: Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(
                parameters: ["email": email, "password": password],
                encoding: JSONEncoding.default
            )

        default:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
}
