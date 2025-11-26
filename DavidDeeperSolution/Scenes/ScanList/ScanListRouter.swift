import UIKit

protocol ScanListRouterLogic {
    func routeToDetails(scan: Scan)
}

final class ScanListRouter: ScanListRouterLogic {
    weak var viewController: UIViewController?

    func routeToDetails(scan: Scan) {
        let vc = AppRouter.shared.makeBathymetryMap(for: scan)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
