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

    @IBAction func updateQuote(_ sender: UIButton) {
        quoteModel.updateQuote()
    }

    @IBAction func moreAbout(_ sender: Any) {

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
