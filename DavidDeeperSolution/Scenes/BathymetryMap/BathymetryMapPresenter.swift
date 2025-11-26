import Foundation

protocol BathymetryMapPresenterInput: AnyObject {
    func present(state: BathymetryMap.Data.State)
    func presentBathymetry(_ dto: BathymetryResponseDTO)
}

final class BathymetryMapPresenter {
    weak var viewController: BathymetryMapViewControllerInput?
}

extension BathymetryMapPresenter: BathymetryMapPresenterInput {
    func present(state: BathymetryMap.Data.State) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.display(state: state)
        }
    }

    func presentBathymetry(_ dto: BathymetryResponseDTO) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.display(bathymetryDTO: dto)
        }
    }
}
