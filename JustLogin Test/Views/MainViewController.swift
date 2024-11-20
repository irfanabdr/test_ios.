//
//  MainViewController.swift
//  JustLogin Test
//
//  Created by Irfan on 20/11/24.
//

import UIKit
import Combine

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var viewModel = MainViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        initTableView()
        
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleState(state)
            }
            .store(in: &cancellables)
        
        viewModel.fetchPosts()
    }
    
    private func initNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.gray
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    private func initTableView() {
        tableView.register(UINib(nibName: PostTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func handleState(_ state: AppState) {
        switch state {
        case .loading:
            self.labelError.isHidden = true
            self.activityIndicator.isHidden = false
        case .success:
            self.activityIndicator.isHidden = true
            self.tableView.reloadData()
        case .error(let message):
            self.activityIndicator.isHidden = true
            self.labelError.text = message
            self.labelError.isHidden = false
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DetailViewController.segue {
            guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            
            let selectedItem = viewModel.posts[indexPath.row]
            detailVC.post = selectedItem
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        let post = viewModel.posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: DetailViewController.segue, sender: self)
    }
}
