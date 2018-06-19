//
//  UserDefaultsHandle.swift
//  RandomQuotes
//
//  Created by Matheus Garcia on 18/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class UserDefaultsHandle: NSObject {

    func firstTime() -> Bool {

        let key = "launchedBefore"
        let launchedBefore = UserDefaults.standard.bool(forKey: key)

        return launchedBefore
    }

    func generateForTheFirstTime() {

        let key = "launchedBefore"

        UserDefaults.standard.set(true, forKey: key)
    }

    func getDefaultQuote() -> Quote? {

        let key = "quotesKey"
        let defaults = UserDefaults.standard

        if let data = defaults.object(forKey: key) as? Data {

            let decorder = JSONDecoder()
            decorder.keyDecodingStrategy = .convertFromSnakeCase

            if let savedQuote = try? decorder.decode(Quote.self, from: data) {

                return savedQuote
            }
        }

        return nil
    }

    func setDefaultQuote(quote: Quote) {

        let encoder = JSONEncoder()

        if let encoded = try? encoder.encode(quote) {

            let defaults = UserDefaults.standard
            let key = "quotesKey"

            defaults.set(encoded, forKey: key)
        }
    }
}
