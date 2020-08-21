//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Oscar Martinez on 8/21/20.
//  Copyright © 2020 oscmg. All rights reserved.
//

import UIKit

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
    
}
