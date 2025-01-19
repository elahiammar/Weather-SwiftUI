import Foundation

public protocol HttpClientProtocol {
    @discardableResult
    func execute<ResponseType: Decodable>(
        _ request: URLRequest
    ) async throws -> ResponseType
}

public class NetworkClient: HttpClientProtocol {
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    private let session: HttpSessionProtocol

    public init(
        decoder: JSONDecoder,
        encoder: JSONEncoder,
        session: HttpSessionProtocol
    ) {
        self.decoder = decoder
        self.encoder = encoder
        self.session = session
    }

    public func execute<ResponseType: Decodable>(
        _ request: URLRequest
    ) async throws -> ResponseType {
        do {
            let (data, _) = try await session.execute(request: request)
            return try parseResponse(data: data)
        } catch {
            let error = error as NSError
            if error.domain == NSURLErrorDomain {
                switch error.code {
                case NSURLErrorNotConnectedToInternet:
                    throw NetworkingError.noNetworkConnection
                case NSURLErrorTimedOut:
                    throw NetworkingError.httpRequestTimedOut
                default:
                    break
                }
            }
            throw error
        }
    }

    private func parseResponse<ResponseType: Decodable>(
        data: Data
    ) throws -> ResponseType {
        do {
            let result = try decoder.decode(ResponseType.self, from: data)
            return result
        } catch {
            throw NetworkingError.error(error)
        }
    }
}

extension Data {
    var jsonString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        else { return nil }

        return prettyPrintedString as String
    }
}
