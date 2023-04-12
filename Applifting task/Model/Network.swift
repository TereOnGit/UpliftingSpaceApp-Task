import Foundation

// struct Crew: Decodable {
//     let createdDate: Date
// }

class Network {
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    
    static var urlSession: URLSession = .shared
    
    static func getLaunches() async throws -> [Launch] {
        guard let url = URL(string: "https://api.spacexdata.com/v5/launches") else {fatalError("Missing URL")}
        let (data, response) = try await urlSession.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error while fetching data")}
        return try decoder.decode([Launch].self, from: data)
    }
}
    
//    static func getCrew() async -> [Crew] {
//        do {
//            let data = try await urlSession.data(from: URL(string: "https://api.spacexdata.com/v5/crew")!).0
//            return try decoder.decode([Crew].self, from: data)
//        } catch {
//            return []
//        }
//    }

