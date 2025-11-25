import Foundation

enum Login {
    enum Data {
        struct Request {
            var email: String
            var password: String
        }

        struct State {
            var isLoading: Bool
            var errorMessage: String?
        }
    }
}
