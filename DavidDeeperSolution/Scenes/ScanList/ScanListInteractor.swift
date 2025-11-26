import Foundation

protocol ScanListInteractorInput {
    func loadScans()
    func didSelectScan(at index: Int)
}

final class ScanListInteractor {
    var presenter: ScanListPresenterInput?

    private let storage: UserStorageProtocol
    private var scans: [Scan] = []

    init(storage: UserStorageProtocol) {
        self.storage = storage
    }
}

extension ScanListInteractor: ScanListInteractorInput {
    func loadScans() {
        scans = storage.load()
        presenter?.present(scans: scans)
    }

    func didSelectScan(at index: Int) {
        guard index < scans.count else { return }
        presenter?.presentScanDetails(scans[index])
    }
}
