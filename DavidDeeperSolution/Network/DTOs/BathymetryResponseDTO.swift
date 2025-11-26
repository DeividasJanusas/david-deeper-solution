struct BathymetryResponseDTO: Decodable {
    let bathymetry: BathymetryDTO
}

struct BathymetryDTO: Decodable {
    let type: String
    let bbox: [Double]
    let features: [BathymetryFeatureDTO]
}

struct BathymetryFeatureDTO: Decodable {
    let type: String
    let properties: BathymetryPropertiesDTO
    let geometry: BathymetryGeometryDTO
}

struct BathymetryPropertiesDTO: Decodable {
    let depth: Double
    let id: String
}

struct BathymetryGeometryDTO: Decodable {
    let type: String
    let bbox: [Double]
    let coordinates: [[[Double]]]
}
