import XCTest
@testable import InkMoya

struct MessageResult: Decodable {
    let message: String
}

final class InkMoyaTests: XCTestCase {
    func testRequest() async throws {
        let session = IMSession.shared
        let (data, res) = try await session.request(api: TestAPI.message)
        XCTAssertEqual(res.statusCode, 200)
        let decoder = JSONDecoder()
        let result = try decoder.decode(MessageResult.self, from: data)
        XCTAssertEqual(result.message, "ok")
    }
}
