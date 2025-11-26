import UIKit
import GoogleMaps

protocol BathymetryMapViewControllerInput: AnyObject {
    func display(state: BathymetryMap.Data.State)
    func display(bathymetryDTO: BathymetryResponseDTO)
}

final class BathymetryMapViewController: UIViewController {
    var interactor: BathymetryMapInteractorInput!

    private var mapView: GMSMapView!
    private let activity = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupUI()
        interactor.loadBathymetryMap()
    }

    private func setupUI() {
        let options = GMSMapViewOptions()
        options.frame = view.bounds

        mapView = GMSMapView(options: options)
        view.addSubview(mapView)

        activity.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activity)

        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension BathymetryMapViewController: BathymetryMapViewControllerInput {
    func display(state: BathymetryMap.Data.State) {
        if state.isLoading {
            activity.startAnimating()
        } else {
            activity.stopAnimating()
        }

        if let error = state.errorMessage {
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }

    func display(bathymetryDTO: BathymetryResponseDTO) {
        // Position camera inside bbox coordinates
        let bbox = bathymetryDTO.bathymetry.bbox
        let southWest = CLLocationCoordinate2D(latitude: bbox[0], longitude: bbox[1])
        let northEast = CLLocationCoordinate2D(latitude: bbox[2], longitude: bbox[3])
        let bounds = GMSCoordinateBounds(coordinate: southWest, coordinate: northEast)

        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 20))

        // Draw polygons
        for feature in bathymetryDTO.bathymetry.features {
            drawPolygon(feature)
        }
    }

    private func drawPolygon(_ feature: BathymetryFeatureDTO) {
        guard let polygonCoordinates = feature.geometry.coordinates.first else { return }

        let path = GMSMutablePath()

        for coordinate in polygonCoordinates {
            let lon = coordinate[0]
            let lat = coordinate[1]
            path.add(CLLocationCoordinate2D(latitude: lat, longitude: lon))
        }

        let polygon = GMSPolygon(path: path)

        // Color for depth
        let depth = feature.properties.depth
        polygon.fillColor = depthToColor(depth)

        polygon.map = mapView
    }

    private func depthToColor(_ depth: Double) -> UIColor {
        // presumed max depth
        let maxDepth: CGFloat = 20.0
        // normalized depth from 0 to 1
        let normalized = CGFloat(min(max(depth / maxDepth, 0), 1))

        let red: CGFloat = 0.1
        let green: CGFloat = 0.4
        let blue: CGFloat = 0.8
        let greenRange: CGFloat = 0.6

        let greenNormalized = green + greenRange * (1 - normalized)

        return UIColor(
            red: red,
            green: greenNormalized,
            blue: blue,
            alpha: 0.6
        )
    }
}
