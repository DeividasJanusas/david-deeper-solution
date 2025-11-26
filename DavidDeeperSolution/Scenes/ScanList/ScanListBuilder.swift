import UIKit

enum ScanListBuilder {
    static func makeScene(
        api: APIClient,
        storage: UserStorageProtocol
    ) -> UIViewController {
        let vc = ScanListViewController()
        let interactor = ScanListInteractor(storage: storage)
        let presenter = ScanListPresenter()
        let router = ScanListRouter()

        vc.interactor = interactor
        vc.router = router
        interactor.presenter = presenter
        presenter.viewController = vc
        router.viewController = vc

        return vc
    }
}
