import UIKit

enum LoginBuilder {
    static func makeScene(
        api: APIClient,
        tokenStore: KeychainService,
        storage: UserStorageProtocol
    ) -> UIViewController {
        let vc = LoginViewController()
        let interactor = LoginInteractor(
            api: api,
            tokenStore: tokenStore,
            storage: storage
        )
        let presenter = LoginPresenter()
        let router = LoginRouter()

        vc.interactor = interactor
        vc.router = router
        interactor.presenter = presenter
        presenter.viewController = vc
        router.viewController = vc

        return vc
    }
}
