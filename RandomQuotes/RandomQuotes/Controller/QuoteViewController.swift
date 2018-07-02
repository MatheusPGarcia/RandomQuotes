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

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var moreAboutButton: UIButton!
    @IBOutlet weak var updateQuoteLabel: UIButton!
    @IBOutlet weak var bluredView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if !(quoteModel.checkInternetConnection()) {
            noConnection()
        }

        let borderColor = UIColor.gray.cgColor

        updateQuoteLabel.layer.borderColor = borderColor
        moreAboutButton.layer.borderColor = borderColor

        quoteModel.setView(view: self)
        quoteModel.adjustLabels()

        bluredView.isHidden = true
    }

    func updateLabels() {

        let currentQuote = quoteModel.quote

        let quoteText = "\"\(currentQuote.quote)\""
        let authorText = "- \(currentQuote.author)"
        let moreAboutText = "More about \(currentQuote.author)"

        quoteLabel.text = quoteText
        authorLabel.text = authorText
        moreAboutButton.setTitle(moreAboutText, for: .normal)
        self.view.layoutIfNeeded()

        stopActivity()
    }

    func noConnection() {
        moreAboutButton.isEnabled = false
        moreAboutButton.setTitleColor(UIColor.gray, for: .normal)

        let action = UIAlertAction(title: "Ok",
                                   style: .default,
                                   handler: nil)
        let alert = UIAlertController(title: "Alert",
                                      message: "No Internet Connection",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)

        stopActivity()
    }

    func startActivity() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        view.addSubview(activityIndicator)

        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()

        bluredView.isHidden = false
    }

    func stopActivity() {
        activityIndicator.stopAnimating()

        let ignoringStatus = UIApplication.shared.isIgnoringInteractionEvents

        if ignoringStatus {
            UIApplication.shared.endIgnoringInteractionEvents()
        }

        bluredView.isHidden = true
    }

    @IBAction func updateQuoteWasPressed(_ sender: UIButton) {

        startActivity()

        if !(quoteModel.checkInternetConnection()) {
            noConnection()
        } else {
            moreAboutButton.isEnabled = true
            moreAboutButton.setTitleColor(UIColor.white, for: .normal)
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

    @IBAction func shareButtonWasPressed(_ sender: UIButton) {

        let quote = quoteModel.quote
        let shareText = "\"\(quote.quote)\"\n- \(quote.author)"

        let activityVC = UIActivityViewController(activityItems: [shareText],
                                                  applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view

        self.present(activityVC, animated: true, completion: nil)
    }
}
