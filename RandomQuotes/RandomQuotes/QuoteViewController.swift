//
//  QuoteViewController.swift
//  RandomQuotes
//
//  Created by Matheus Garcia on 15/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class QuoteViewController: UIViewController {

    var quoteModel = Model()

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var moreAboutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        if !(quoteModel.checkInternetConnection()) {
            noConnection()
        }

        quoteModel.setView(view: self)
    }

    func updateLabels() {

        let currentQuote = quoteModel.quote

        let quoteText = "\"\(currentQuote.text)\""
        let authorText = "- \(currentQuote.author)"
        let moreAboutText = "More about \(currentQuote.author)"

        quoteLabel.text = quoteText
        authorLabel.text = authorText
        moreAboutButton.setTitle(moreAboutText, for: .normal)
        self.view.layoutIfNeeded()
    }

    func noConnection() {
        moreAboutButton.isEnabled = false

        let action = UIAlertAction(title: "Ok",
                                   style: .default,
                                   handler: nil)
        let alert = UIAlertController(title: "Alert",
                                      message: "No Internet Connection",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func updateQuoteWasPressed(_ sender: UIButton) {

        if !(quoteModel.checkInternetConnection()) {
            noConnection()
        } else {
            moreAboutButton.isEnabled = true
            quoteModel.updateQuote()
        }
    }

    @IBAction func moreAboutWasPressed(_ sender: Any) {

        if !(quoteModel.checkInternetConnection()) {
            noConnection()
            return
        }

        var author = quoteModel.quote.author
        author = author.replacingOccurrences(of: " ", with: "+")

        let urlString = "http://www.google.com/search?q=\(author)"

        let url = URL(string: urlString)

        if let url = url {
            UIApplication.shared.canOpenURL(url)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
