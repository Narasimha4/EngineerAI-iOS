/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

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