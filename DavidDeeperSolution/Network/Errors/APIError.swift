enum APIError: Error {
    case network(String)
    case server(status: Int, message: String?)
    case decoding(String)
}
