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

    override func viewDidLoad() {
        super.viewDidLoad()

        quoteModel.setView(view: self)
    }

    func updateLabels() {

        let currentQuote = quoteModel.quote

        let quoteText = "\"\(currentQuote.text)\""
        let authorText = "- \(currentQuote.author)"

        quoteLabel.text = quoteText
        authorLabel.text = authorText
    }

    @IBAction func updateQuote(_ sender: UIButton) {
        quoteModel.updateQuote()
    }
}
