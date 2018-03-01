//
//  QuoteView.swift
//  QuotePro
//
//  Created by Eric Gregor on 2018-02-28.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

import UIKit

class QuoteView: UIView {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func setupWithQuote(quote: Quote) {
        if let imageData = quote.photo?.image {
            photoView.image = UIImage(data: imageData as Data)
        }
        quoteLabel.text = quote.quoteText
        authorLabel.text = quote.author
    }

}
