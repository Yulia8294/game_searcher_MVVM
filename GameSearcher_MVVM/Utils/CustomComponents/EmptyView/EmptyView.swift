//
//  EmptyView.swift
//  GameSearcher_MVVM
//
//  Created by Yulia Novikova on 4/16/21.
//

import UIKit

class EmptyView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           commonInit()
       }
       
    func commonInit() {
        Bundle.main.loadNibNamed("EmptyView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
