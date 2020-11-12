//
//  DetailViewController.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    var data: ImgurModel.Data!
    private var navigator: DetailsNavigator?
    static func makeViewController(data: ImgurModel.Data, navigator: DetailsNavigator) -> DetailViewController {
        let vc = DetailViewController.instantiateFromStoryboard("Main", storyboardId: "DetailViewController")
        vc.data = data
        vc.navigator = navigator
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = (data.title ?? "") + "\n" + (data.description ?? "")
        if let url = data.url {
            ImageHelper.sharedInstance.downloadImage(url: url) { [weak self] image in
                guard let image = image else {
                    self?.detailImage.image = UIImage(named: "imgur-default")
                    return
                }
                self?.detailImage.image = image
            }
        } else {
            detailImage.image = UIImage(named: "imgur-default")
        }
    }
}
