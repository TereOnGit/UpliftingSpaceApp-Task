import Foundation

struct Launch: Identifiable, Decodable {
    let id: String
    let dateUnix: Date
    let name: String
    let details: String?
}

extension Launch {
    static var launchWithDetails = Launch(id: "123", dateUnix: Date(), name: "Test", details: "Funguje")
    static var launchWithoutDetails = Launch(id: "123", dateUnix: Date(), name: "Test", details: nil)
}
