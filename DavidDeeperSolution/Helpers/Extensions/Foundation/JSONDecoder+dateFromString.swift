import Foundation

public extension JSONDecoder {
    static func withAPIDefaultsStringDates() -> JSONDecoder {
        let decoder = JSONDecoder()

        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)
            let style = Date.ISO8601FormatStyle()

            if let parsed = try? style.time(includingFractionalSeconds: true).parse(value) {
                return parsed
            }
            if let parsed = try? style.parse(value) {
                return parsed
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Expected ISO-8601 string date, got: \(value)",
            )
        }

        return decoder
    }
}
