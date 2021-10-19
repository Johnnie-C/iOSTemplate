//
//  ListCell.swift
//  iOSTemplate
//
//  Created by Johnnie Cheng on 19/10/21.
//

import UIKit
import AlamofireImage

class ListCell: UITableViewCell {

    @IBOutlet var cellImageView: UIImageView!
    @IBOutlet var cellTitleLabel: UILabel!
    private var item: ListEntity?

    func updateUI(item: ListEntity) {
        self.item = item
        cellImageView.image = nil
        cellImageView.af.cancelImageRequest()

        if let imageURLStr = item.avatar,
           !imageURLStr.isEmpty,
           let url = URL(string: imageURLStr)
        {
            cellImageView.af.setImage(withURL: url)
        }

        cellTitleLabel.text = item.name
    }
    
}
