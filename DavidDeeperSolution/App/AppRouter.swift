import UIKit

final class AppRouter {
    lazy var window = UIWindow()

    static let shared = AppRouter()

    private let api: APIClient = MoyaAPIClient()
    private let tokenStore = KeychainService()
    private let userDefaultsStore = UserDefaultsStorage()

    private init() { }

    func start() {
        var vc: UIViewController
        if tokenStore.token == nil {
            vc = makeLogin()
        } else {
            vc = makeScanList()
        }

        window.makeKeyAndVisible()
        window.rootViewController = UINavigationController(rootViewController: vc)
    }

    func makeLogin() -> UIViewController {
        return LoginBuilder.makeScene(
            api: api,
            tokenStore: tokenStore,
            storage: userDefaultsStore
        )
    }

    func makeScanList() -> UIViewController {
        return ScanListBuilder.makeScene(
            api: api,
            storage: userDefaultsStore
        )
    }
}
