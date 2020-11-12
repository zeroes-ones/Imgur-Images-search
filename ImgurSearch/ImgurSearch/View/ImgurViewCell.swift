//
//  ImgurViewCell.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation
import UIKit

final class ImgurViewCell: UITableViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var titleDescription: UILabel!

    override func awakeFromNib() {
        activityIndicator.startAnimating()
        cellImageView.clipsToBounds = true
        cellImageView.contentMode = .scaleAspectFit
    }

    func setData(_ data: ImgurModel.Data, imageHelper: ImageHelper) {
        title.text = data.title ?? ""
        titleDescription.text = data.description ?? ""
        // check for url
        if let url = data.url {
            imageHelper.downloadImage(url: url) { [weak self] image in
                guard let self = self else {
                    return
                }
                self.activityIndicator.stopAnimating()
                guard let image = image else {
                    self.cellImageView.image = UIImage(named: "imgur-default")?.resizedImage(for: CGSize(width: 80, height: 80))
                    return
                }
                self.cellImageView.image = image.resizedImage(for: CGSize(width: 80, height: 80))
            }
        } else {
            self.activityIndicator.stopAnimating()
            cellImageView.image = UIImage(named: "imgur-default")?.resizedImage(for: CGSize(width: 80, height: 80))
        }
    }
}
