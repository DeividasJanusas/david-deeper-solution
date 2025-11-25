import UIKit

protocol LoginRoutingLogic {
    func routeToMain()
}

final class LoginRouter: LoginRoutingLogic {
    weak var viewController: UIViewController?

    func routeToMain() {
        // TODO: - Implement scans list
//        viewController?.navigationController?.setViewControllers([vc], animated: true)
    }
}
