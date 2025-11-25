import UIKit

final class AppRouter {
    lazy var window = UIWindow()
    static let shared = AppRouter()
    private let api: APIClient = MoyaAPIClient()
    private let tokenStore = KeychainService()

    private init() { }

    func start() {
        if tokenStore.token == nil {
            showLogin()
        } else {
            // TODO: - Implement scans list
        }

        window.makeKeyAndVisible()
    }

    func showLogin() {
        let vc = LoginBuilder.makeScene(api: api, tokenStore: tokenStore)
        window.rootViewController = UINavigationController(rootViewController: vc)
    }
}
