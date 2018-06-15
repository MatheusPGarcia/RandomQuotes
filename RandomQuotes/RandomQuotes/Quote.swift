//
//  Quote.swift
//  RandomQuotes
//
//  Created by Matheus Garcia on 15/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct Quote {
    let text: String
    let author: String

    init(quote: String, author: String) {
        self.text = "If you don't have internet, you can't get new quotes"
        self.author = "From this app developer"
    }
}

extension Quote: Decodable {
    enum StructKeys: String, CodingKey {
        case quote
        case author
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StructKeys.self)

        let quote: String = try container.decode(String.self, forKey: .quote)
        let author: String = try container.decode(String.self, forKey: .author)

        self.text = quote
        self.author = author
    }
}
