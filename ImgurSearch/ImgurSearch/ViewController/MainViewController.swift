//
//  MainViewController.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchFooter: SearchFooter!
    @IBOutlet private weak var searchFooterBottomConstraint: NSLayoutConstraint!

    private let searchController = UISearchController(searchResultsController: nil)
    private var viewModel: ImgurViewModel!
    private var navigator: DetailsNavigator?

    static func makeViewController(viewModel: ImgurViewModel, navigator: DetailsNavigator) -> MainViewController {
        let vc = MainViewController.instantiateFromStoryboard("Main", storyboardId: "MainViewController")
        vc.viewModel = viewModel
        vc.navigator = navigator
        return vc
    }
}

extension MainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBarConfiguration()
        definesPresentationContext = true
        // setup keyboard notifications
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification,
                                       object: nil, queue: .main) { (notification) in
                                        self.handleKeyboard(notification: notification) }
        notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                       object: nil, queue: .main) { (notification) in
                                        self.handleKeyboard(notification: notification) }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.searchBar.becomeFirstResponder()
        searchFooter.setIsFilteringToShow(filteredItemCount: viewModel.results.count, of: viewModel.totalRecords)
    }
}

private extension MainViewController {
    func setSearchBarConfiguration() {
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search"
        // 4
        navigationItem.searchController = searchController
        // 5
        searchController.searchBar.delegate = self
        //6
        searchController.searchBar.scopeButtonTitles = ImgurViewModel.SearchCategory.allCases.map { $0.rawValue }
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(String(describing: searchController.searchBar.text))
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard let searchCategory = searchBar.scopeButtonTitles?[selectedScope] else {
            return
        }
        viewModel.searchCategory = ImgurViewModel.SearchCategory(rawValue: searchCategory) ?? .all
        tableView.reloadData()
        searchFooter.setIsFilteringToShow(filteredItemCount: viewModel.results.count, of: viewModel.totalRecords)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        viewModel.fetchImgurGallery(text: searchBar.text ?? "") { [weak self] result in
            guard let self = self else {
                return
            }
            self.tableView.reloadData()
            self.searchFooter.setIsFilteringToShow(filteredItemCount: self.viewModel.results.count, of: self.viewModel.totalRecords)
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigator?.navigate(to: .detailView(viewModel.results[indexPath.row]), type: .push)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ImgurViewCell else {
            return UITableViewCell()
        }
        cell.setData(viewModel.results[indexPath.row], imageHelper: ImageHelper.sharedInstance)
        return cell
    }
}

//MARK: - Scrollview Delegate
extension MainViewController: UIScrollViewDelegate {

    //MARK :- Getting user scroll down event here
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height)), !viewModel.isSearchEmpty {
                //Start loading new data from here
                viewModel.fetchImgurGallery { [weak self] result in
                    guard let self = self else {
                        return
                    }
                    self.tableView.reloadData()
                    self.searchFooter.setIsFilteringToShow(filteredItemCount: self.viewModel.results.count, of: self.viewModel.totalRecords)
                }
            }
        }
    }

    // MARK :- Hide keyboard if active on searchbar
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.resignFirstResponder()
    }
}

private extension MainViewController {
    func handleKeyboard(notification: Notification) {
        // 1
        guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
            searchFooterBottomConstraint.constant = 0
            view.layoutIfNeeded()
            return
        }

        guard
            let info = notification.userInfo,
            let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else {
                return
        }

        // 2
        let keyboardHeight = keyboardFrame.cgRectValue.size.height
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.searchFooterBottomConstraint.constant = keyboardHeight
            self.view.layoutIfNeeded()
        })
    }
}
