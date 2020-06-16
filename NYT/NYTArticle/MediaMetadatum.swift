// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let mediaMetadatum = try? newJSONDecoder().decode(MediaMetadatum.self, from: jsonData)

import Foundation

// MARK: - MediaMetadatum
struct MediaMetadatum: Codable {
    var url: String?
    var format: Format?
    var height, width: Int?
}
