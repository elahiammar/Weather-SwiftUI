public protocol UseCase {
    associatedtype Input
    associatedtype Output

    func execute(with input: Input) async throws -> Output
}
