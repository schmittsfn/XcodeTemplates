//___FILEHEADER___

import CoreLocation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

/// A firebase model representing X
struct ___FILEBASENAMEASIDENTIFIER___ {
    @DocumentID private(set) var id: String?
    let location: GeoPoint?
    @ServerTimestamp private(set) var createdAt: Date?
    @ServerTimestamp private(set) var updatedAt: Date?
    
    // MARK: Initialisers
    init(location: CLLocationCoordinate2D?) {
        id = nil
        self.location = GeoPoint(latitude: location.latitude, longitude: location.longitude)
        createdAt = nil
        updatedAt = nil
    }
}

// MARK: - Codable
extension ___FILEBASENAMEASIDENTIFIER___: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case location
        case createdAt
        case updatedAt
    }
}

extension ___FILEBASENAMEASIDENTIFIER___: Hashable {}
