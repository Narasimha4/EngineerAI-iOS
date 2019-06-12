//
//  HighlightResult.swift
//  EngineerAI-iOS
//
//  Created by Narasimha on 12/06/19.
//  Copyright © 2019 fissionlabs. All rights reserved.
//

import Foundation
struct HighlightResult : Codable {
	let title : Title?
	let url : Url?
	let author : Author?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case url = "url"
		case author = "author"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(Title.self, forKey: .title)
		url = try values.decodeIfPresent(Url.self, forKey: .url)
		author = try values.decodeIfPresent(Author.self, forKey: .author)
	}
}
