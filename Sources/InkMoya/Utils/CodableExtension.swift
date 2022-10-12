import Foundation

public extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}