//
//  ViewController.swift
//  spaceX
//
//  Created by Cem Nisan on 10.12.2021.
//

import UIKit

protocol ICapsulesViewController: AnyObject {
    func didUpdateCapsules(capsules: [Capsules])
    func didUpdateIndicator(isLoad: Bool)
    func didFailWithError(error: NetworkError)
}

// MARK: - Initialize
class CapsulesViewController: UIViewController {
    
    @IBOutlet weak var loadingUIView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var capsulesTableView: UITableView!

    private var segmentTitle:String?
    private var spaceXCapsules = [Capsules]()
    private lazy var capsulesViewModel: CapsulesViewModel = {
        return CapsulesViewModel(networkService: NetworkService(), delegate: self)
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        capsulesViewModel.fetchAllCapsules()
    }
}

// MARK: - Buttons Pressed
extension CapsulesViewController {
    
    @IBAction func segmentPressed(_ sender: UISegmentedControl) {
        segmentTitle = sender.titleForSegment(at: sender.selectedSegmentIndex)
        
        guard let title = segmentTitle else { return }
        
        fetchCapsules(with: title)
    }
    
    @IBAction func onRefreshPressed(_ sender: Any) {
        guard let title = segmentTitle else { return }
        
        fetchCapsules(with: title)
    }
}

// MARK: - Fetch Capsules
extension CapsulesViewController {
    
    func fetchCapsules(with title: String) {
        let context = SelectContext.getContext(title)
        context?.fetchCapsules(title, viewModel: capsulesViewModel)
    }
}

// MARK: - Update Views Operations
extension CapsulesViewController: ICapsulesViewController {
    
    func didUpdateCapsules(capsules: [Capsules]) {
        spaceXCapsules.removeAll()
        capsulesTableView.reloadData()
        capsulesTableView.separatorStyle = .none
        loadingUIView.isHidden = false
  
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 , execute: {
            self.spaceXCapsules = capsules
            self.capsulesTableView.reloadData()
            self.loadingUIView.isHidden = true
            self.capsulesTableView.separatorStyle = .singleLine
        })
    }
    
    func didUpdateIndicator(isLoad: Bool) {
        isLoad ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
    }
    
    func didFailWithError(error: NetworkError) {
        print(error)
    }
}

// MARK: - Table View Operations
extension CapsulesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spaceXCapsules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = capsulesTableView
                .dequeueReusableCell(
                    withIdentifier: K.App.reuseIdentifier,
                    for: indexPath) as? CapsulesTableViewCell else { return UITableViewCell() }
        
        let capsule = spaceXCapsules[indexPath.row]
        cell.configureUI(with: capsule)
        
        return cell
    }
}

// MARK: - Configure View Operations
extension CapsulesViewController {
    
    func configureView() {
        capsulesTableView.dataSource = self
        capsulesTableView.separatorStyle = .none
        capsulesTableView.register(UINib(nibName: K.App.nibName, bundle: nil), forCellReuseIdentifier: K.App.reuseIdentifier)
        
        loadingUIView.layer.cornerRadius = 6
        loadingUIView.isHidden = true
    }
}
