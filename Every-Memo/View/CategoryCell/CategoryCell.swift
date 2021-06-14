//
//  CategoryCell.swift
//  Every-Memo
//
//  Created by 相良 詠斗 on 2021/06/11.
//

import UIKit

class CategoryCell: UITableViewCell {

    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var endIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
