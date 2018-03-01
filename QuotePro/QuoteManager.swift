//
//  QuoteManager.swift
//  QuotePro
//
//  Created by Eric Gregor on 2018-02-28.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

import Foundation

struct QuoteManager {
    
    static func generateQuote(completionHandler: @escaping (String, String) -> Void) {
        let url = URL(string: "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        //let session = URLSession(configuration: URLSessionConfiguration.default)
       let session = URLSession.shared
        session.dataTask(with: url! as URL, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            do {
                let jsonData: NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let quoteText = jsonData["quoteText"] as! String
                let quoteAuthor = jsonData["quoteAuthor"] as! String

                completionHandler(quoteText, quoteAuthor)

            } catch {
                print(error)
            }
        }).resume()
        
//        let url = URL(string: "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json")
//        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
//            guard let data = data, error == nil else { return }
//
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
//                let posts = json["posts"] as? [[String: Any]] ?? []
//                print(posts)
//            } catch let error as NSError {
//                print(error)
//            }
//        }).resume()

    }
    
}
