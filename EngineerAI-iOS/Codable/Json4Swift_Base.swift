

import Foundation
struct Json4Swift_Base : Codable {
	let hits : [Hits]?
	let nbHits : Int?
	let page : Int?
	let nbPages : Int?
	let hitsPerPage : Int?
	let processingTimeMS : Int?
	let exhaustiveNbHits : Bool?
	let query : String?
	let params : String?

	enum CodingKeys: String, CodingKey {

		case hits = "hits"
		case nbHits = "nbHits"
		case page = "page"
		case nbPages = "nbPages"
		case hitsPerPage = "hitsPerPage"
		case processingTimeMS = "processingTimeMS"
		case exhaustiveNbHits = "exhaustiveNbHits"
		case query = "query"
		case params = "params"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		hits = try values.decodeIfPresent([Hits].self, forKey: .hits)
		nbHits = try values.decodeIfPresent(Int.self, forKey: .nbHits)
		page = try values.decodeIfPresent(Int.self, forKey: .page)
		nbPages = try values.decodeIfPresent(Int.self, forKey: .nbPages)
		hitsPerPage = try values.decodeIfPresent(Int.self, forKey: .hitsPerPage)
		processingTimeMS = try values.decodeIfPresent(Int.self, forKey: .processingTimeMS)
		exhaustiveNbHits = try values.decodeIfPresent(Bool.self, forKey: .exhaustiveNbHits)
		query = try values.decodeIfPresent(String.self, forKey: .query)
		params = try values.decodeIfPresent(String.self, forKey: .params)
	}

}
