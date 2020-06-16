// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let nYTArticleElement = try? newJSONDecoder().decode(NYTArticleElement.self, from: jsonData)

import Foundation

// MARK: - NYTArticleElement
struct NYTArticleElement: Codable {
    var uri: String?
    var url: String?
    var id, assetID: Int?
    var source: Source?
    var publishedDate, updated, section, subsection: String?
    var nytdsection, adxKeywords: String?
    var column: JSONNull?
    var byline: String?
    var type: NYTArticleType?
    var title, abstract: String?
    var desFacet, orgFacet, perFacet, geoFacet: [String]?
    var media: [Media]?
    var etaID: Int?

    enum CodingKeys: String, CodingKey {
        case uri, url, id
        case assetID = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated, section, subsection, nytdsection
        case adxKeywords = "adx_keywords"
        case column, byline, type, title, abstract
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case etaID = "eta_id"
    }
}
