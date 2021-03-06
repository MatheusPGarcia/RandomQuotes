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
        let author = "Developer"

        quote = Quote(quote: quoteText, author: author)
    }

    func updateQuote() {

        let service = QuoteService()
        service.updateQuote(model: self)
    }

    func checkInternetConnection() -> Bool {

        let internetStatus = InternetConnenction.checkCconnection()

        if !internetStatus {
            return false
        }

        return true
    }

    func quoteHasChanged() {

        if let view = view {
            view.updateLabels()
        }

        let defaults = UserDefaultsHandle()
        defaults.setDefaultQuote(quote: quote)

        return
    }

    func adjustLabels() {

        let defaults = UserDefaultsHandle()

        if !defaults.firstTime() {

            defaults.generateForTheFirstTime()
            return
        }
        guard let quoteDefault = defaults.getDefaultQuote() else { return }
        quote = quoteDefault
        quoteHasChanged()
    }

    func setView(view: QuoteViewController) {
        self.view = view
    }
}
