//
//  QuoteService.swift
//  RandomQuotes
//
//  Created by Matheus Garcia on 15/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import Alamofire

class QuoteService: NSObject {

    func updateQuote(model: Model) {

        let url = "https://andruxnet-random-famous-quotes.p.mashape.com/?cat=famous&count=1"
        let xMashapeKey = "VmE3XJQFNwmshGI3us3JoFBm4oqBp1RGpwVjsn9L9FhPiH934C"

        let header = ["X-Mashape-Key": xMashapeKey,
                      "Content-Type": "application/x-www-form-urlencoded",
                      "Accept": "application/json"]

        Alamofire.request(url, headers: header).response { response in

            guard let data = response.data else {
                return
            }

            do {
                let decoder = JSONDecoder()
                let quoteArray = try decoder.decode([Quote].self, from: data)
                let newQuote = quoteArray.first

                if let quote = newQuote {
                    model.quote = quote
                    model.quoteHasChanged()
                }

            } catch let jsonErr {
                print("Failed to decode: ", jsonErr)
            }
        } .resume()
    }
}
