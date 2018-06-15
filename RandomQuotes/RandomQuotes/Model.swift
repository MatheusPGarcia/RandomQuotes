//
//  Model.swift
//  RandomQuotes
//
//  Created by Matheus Garcia on 15/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import Alamofire

class Model: NSObject {

    var quote: Quote
    weak var view: QuoteViewController?

    override init() {
        let quoteText = "If you don't have internet, you can't get new quotes"
        let author = "From this app developer"

        quote = Quote(quote: quoteText, author: author)
    }

    func updateQuote() {
        let service = QuoteService()
        service.updateQuote(model: self)
    }

    func quoteHasChanged() {

        if let view = view {
            view.updateLabels()
        }
        print("It's time:\n\(quote.text)\n\(quote.author)")
        return
    }

    func setView(view: QuoteViewController) {
        self.view = view
    }
}