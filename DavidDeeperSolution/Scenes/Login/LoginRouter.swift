import UIKit

protocol LoginRoutingLogic {
    func routeToScanList()
}

final class LoginRouter: LoginRoutingLogic {
    weak var viewController: UIViewController?

    func routeToScanList() {
        // TODO: - Implement scans list
//        viewController?.navigationController?.setViewControllers([vc], animated: true)
    }
}
