import UIKit

protocol ScanListRouterLogic {
    func routeToDetails(scan: Scan)
}

final class ScanListRouter: ScanListRouterLogic {
    weak var viewController: UIViewController?

    func routeToDetails(scan: Scan) {
// TODO: - Implement batimetry map scene
//        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
