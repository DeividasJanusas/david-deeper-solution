import UIKit

protocol LoginRoutingLogic {
    func routeToScanList()
}

final class LoginRouter: LoginRoutingLogic {
    weak var viewController: UIViewController?

    func routeToScanList() {
        let vc = AppRouter.shared.makeScanList()
        viewController?.navigationController?.setViewControllers([vc], animated: true)
    }
}
