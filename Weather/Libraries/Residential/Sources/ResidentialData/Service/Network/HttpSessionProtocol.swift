import Foundation

public protocol HttpSessionProtocol {
    func execute(request: URLRequest) async throws -> (Data, URLResponse)
}
