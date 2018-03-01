//
//  DetailViewController.swift
//  QuotePro
//
//  Created by Eric Gregor on 2018-02-28.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

import UIKit

protocol QuoteDelegate {
    func updateTableView(quote: Quote)
}

class DetailViewController: UIViewController {

    @IBOutlet var builderView: UIView!
    @IBOutlet weak var previewView: UIView!
    
    var quote: Quote = Quote()
    var quoteView: QuoteView?
    
    var delegate : QuoteDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        quoteView = Bundle.main.loadNibNamed("QuoteView", owner: nil, options: nil)?.first! as? QuoteView
        quoteView?.frame.size = previewView.frame.size
        previewView.addSubview(quoteView!)
        
        newQuote()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func quoteButtonTapped(_ sender: UIButton) {
        QuoteManager.generateQuote(completionHandler: { [weak self] (quoteText: String, quoteAuthor: String) in
            
            self?.quote.quoteText = quoteText
            self?.quote.author = quoteAuthor
            
            self?.reset()
        })

    }
    
    @IBAction func imageButtonTapped(_ sender: UIButton) {
        PhotoManager.generatePhoto(completionHandler: { [weak self] (photo: UIImage) in
            print(photo)
            
            self?.quote.photo?.image = NSData(data: UIImageJPEGRepresentation(photo, 1.0)!)
            
            self?.reset()
        })

    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if delegate != nil {
            delegate?.updateTableView(quote: self.quote)
            //dismiss the modal
            dismiss(animated: true, completion: nil)
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func newQuote() {
        PhotoManager.generatePhoto(completionHandler: { [weak self] (photo: UIImage) in
            print(photo)
            
            self?.quote.photo = Photo()
            self?.quote.photo?.image = NSData(data: UIImageJPEGRepresentation(photo, 1.0)!)
            
            self?.reset()
        })
        
        QuoteManager.generateQuote(completionHandler: { [weak self] (quoteText: String, quoteAuthor: String) in
            
            self?.quote.quoteText = quoteText
            self?.quote.author = quoteAuthor
            
            self?.reset()
        })
    }
    
    func reset() {
        DispatchQueue.main.async {
            self.quoteView?.setupWithQuote(quote: self.quote)
        }
    }
    
}
