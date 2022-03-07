//
//  FindViewController.swift
//  GitFind
//
//  Created by Misha Fedorov on 05.03.2022.
//

import UIKit

final class FindViewController: BaseViewController {

    private let searchViewController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView()
    private let viewModel: FindViewModel
    
    init(_ viewModel: FindViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        bindViewModel()
    }
    
    func setupUI() {
        title = "Search"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchViewController
        setupSearchViewController()
        setupTableView()
    }

    private func setupSearchViewController() {
        searchViewController.searchResultsUpdater = self
        searchViewController.searchBar.placeholder = "Search repositories"
        searchViewController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(FindItemCell.self, forCellReuseIdentifier: "Cell")
        
        SearchService().search(request: SearchRequestModel(query: "treelllo", resultCount: 25, page: 1)).subscribe(onSuccess: { _ in
            print("Ok")
        })
    }

    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.resultRelay.subscribe(onNext: { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}

extension ViewControllerFactoryProtocol {
    static func createFindViewController() -> FindViewController {
        let viewModel = FindScreenViewModel()
        let controller = FindViewController(viewModel)
        controller.modalPresentationStyle = .fullScreen
        return controller
    }
}

extension FindViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.execute(query: searchController.searchBar.text)
    }
}

extension FindViewController: UITableViewDelegate {

}

extension FindViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let model = viewModel.viewModelFor(indexPath)
        model.setup(any: cell)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: -1000, y: 0)
        cell.alpha = 0
        UIView.animate(withDuration: 0.6, animations: {
            cell.transform = CGAffineTransform.identity
            cell.alpha = 1
        })
    }
}
