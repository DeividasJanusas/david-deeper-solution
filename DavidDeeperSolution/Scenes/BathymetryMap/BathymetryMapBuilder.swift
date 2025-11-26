import UIKit

enum BathymetryMapBuilder {
    static func makeScene(
        scan: Scan,
        api: APIClient,
        tokenStore: KeychainService
    ) -> UIViewController {
        let vc = BathymetryMapViewController()
        let interactor = BathymetryMapInteractor(
            scan: scan,
            api: api,
            tokenStore: tokenStore
        )
        let presenter = BathymetryMapPresenter()

        vc.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = vc

        return vc
    }
}
