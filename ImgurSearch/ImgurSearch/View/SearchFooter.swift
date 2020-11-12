//
//  SearchFooter.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation
import UIKit
final class SearchFooter: UIView {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureView()
    }

    override func draw(_ rect: CGRect) {
        label.frame = bounds
    }

    func setNotFiltering() {
        label.text = ""
        hideFooter()
    }

    func setIsFilteringToShow(filteredItemCount: Int, of totalItemCount: Int) {
        if (filteredItemCount == 0) {
            label.text = "No items match your query"
            showFooter()
        } else {
            label.text = "\(filteredItemCount) of \(totalItemCount)"
            showFooter()
        }
    }

    func hideFooter() {
        UIView.animate(withDuration: 0.7) {
            self.alpha = 0.0
        }
    }

    func showFooter() {
        UIView.animate(withDuration: 0.7) {
            self.alpha = 1.0
        }
    }

    func configureView() {
        backgroundColor = UIColor.lightGray
        alpha = 0.5

        label.textAlignment = .center
        label.textColor = UIColor.white
        addSubview(label)
    }
}
