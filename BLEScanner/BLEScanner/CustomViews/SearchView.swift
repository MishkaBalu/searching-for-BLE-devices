//
//  SearchView.swift
//  BLEScanner
//
//  Created by Administrator on 05.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    //MARK: - Outlets
    @IBOutlet weak var searchImageView: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func animateSearching() {
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       options: [.autoreverse, .repeat, .allowUserInteraction],
                       animations: { self.searchImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        })
    }
}
