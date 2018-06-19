//
//  TodayViewController.swift
//  RandomQuotes Widget
//
//  Created by Matheus Garcia on 18/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {

    @IBOutlet weak var quoteTextLabel: UILabel!
    @IBOutlet weak var authorTextLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if !firstTime() {
            quoteTextLabel.text = "\"It was a pleasure to develop this app\""
            authorTextLabel.text = "-Developer"
        } else {
            guard let quote = getDefaultQuote() else { return }
            quoteTextLabel.text = "\"\(quote.quote)\""
            authorTextLabel.text = "- \(quote.author)"
        }

        widgetPerformUpdate { (_) in }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {

        completionHandler(NCUpdateResult.newData)
    }

    func firstTime() -> Bool {

        let groupName = "group.matheuspgarcia.randomQuotes"
        guard let defaults = UserDefaults(suiteName: groupName) else { return true }

        let key = "launchedBefore"
        let launchedBefore = defaults.bool(forKey: key)

        return launchedBefore
    }

    func getDefaultQuote() -> Quote? {

        let groupName = "group.matheuspgarcia.randomQuotes"
        guard let defaults = UserDefaults(suiteName: groupName) else { return nil }

        let key = "quotesKey"

        if let data = defaults.object(forKey: key) as? Data {

            let decorder = JSONDecoder()
            decorder.keyDecodingStrategy = .convertFromSnakeCase

            if let savedQuote = try? decorder.decode(Quote.self, from: data) {

                return savedQuote
            }
        }

        return nil
    }

    @IBAction func openApplication(_ sender: UIButton) {

        guard let url: NSURL = NSURL(string: "RandomQuotes://") else { return }

        self.extensionContext?.open(url as URL, completionHandler: nil)
    }
}
