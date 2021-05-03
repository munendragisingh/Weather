//
//  LoadingLabel.swift
//  Weather
//
//  Created by Pratap SIngh on 03/05/21.
//

import UIKit

class LoadingLabel: UILabel {
    var timer: Timer?
    
    func startLoading() {
        self.text = " "
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if(self.text == " "){
                self.text = "."
            }else if(self.text == "."){
                self.text = ".."
            }else if(self.text == ".."){
                self.text = "..."
            }else if(self.text == "..."){
                self.text = " "
            }
        }
    }
    
    func stopLoading() {
        timer?.invalidate()
        timer = nil
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
