import Foundation

public extension JSONDecoder {
    static func withAPIDefaultsStringDates() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            // Handle null
            if container.decodeNil() {
                return Date.distantPast
            }

            let value = try container.decode(String.self)

            let isoFormatter = ISO8601DateFormatter()
            isoFormatter.formatOptions = [
                .withInternetDateTime,
                .withFractionalSeconds
            ]

            if let date = isoFormatter.date(from: value) {
                return date
            }

            let isoFormatterNoFraction = ISO8601DateFormatter()
            isoFormatterNoFraction.formatOptions = [.withInternetDateTime]

            if let date = isoFormatterNoFraction.date(from: value) {
                return date
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Unrecognized ISO8601 date format: \(value)"
            )
        }

        return decoder
    }
}
