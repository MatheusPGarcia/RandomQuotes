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

    func updateQuote() {

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
                let quote = quoteArray.first

                if let quote = quote {
                    // Here you have the quote
                }

            } catch let jsonErr {
                print("Failed to decode: ", jsonErr)
            }
        } .resume()
    }
}
