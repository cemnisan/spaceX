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

class CapsulesViewController: UIViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var capsulesTableView: UITableView! {
        didSet {
            capsulesTableView.dataSource = self
            capsulesTableView.separatorStyle = .none
            capsulesTableView.register(UINib(nibName: K.App.nibName, bundle: nil), forCellReuseIdentifier: K.App.reuseIdentifier)
        }
    }

    private var segmentTitle:String?
    private var spaceXCapsules = [Capsules]()
    private lazy var capsulesViewModel: CapsulesViewModel = {
        return CapsulesViewModel(networkService: NetworkService(), delegate: self)
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        capsulesViewModel.fetchAllCapsules()
    }
    
    @IBAction func segmentPressed(_ sender: UISegmentedControl) {
        segmentTitle = sender.titleForSegment(at: sender.selectedSegmentIndex)
       
        if let title = segmentTitle {
            fetchCapsulesWithSegmentTitle(segmentTitle: title)
        }
    }
    
    @IBAction func onRefreshPressed(_ sender: Any) {
    
        if let title = segmentTitle {
            fetchCapsulesWithSegmentTitle(segmentTitle: title)
        } else {
            capsulesViewModel.fetchAllCapsules()
        }
    
    }
    
    private func fetchCapsulesWithSegmentTitle(segmentTitle: String) {
        switch segmentTitle {
        
        case K.SegmentTitle.allCapsules.rawValue:
            capsulesViewModel.fetchAllCapsules()
          
        case K.SegmentTitle.upComing.rawValue:
            capsulesViewModel.fetchUpComingCapsules()
    
        case K.SegmentTitle.past.rawValue:
            capsulesViewModel.fetchPastCapsules()
       
        default:
            return
        }
    }
    
}

extension CapsulesViewController: ICapsulesViewController {
    
    func didUpdateCapsules(capsules: [Capsules]) {
        spaceXCapsules.removeAll()
        capsulesTableView.reloadData()
        capsulesTableView.separatorStyle = .none
        loadingIndicator.isHidden = false
  
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 , execute: {
            self.loadingIndicator.isHidden = true
            self.spaceXCapsules = capsules
            self.capsulesTableView.reloadData()
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

extension CapsulesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.spaceXCapsules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = capsulesTableView.dequeueReusableCell(withIdentifier: K.App.reuseIdentifier, for: indexPath) as? CapsulesTableViewCell else { return UITableViewCell() }
        let capsule = spaceXCapsules[indexPath.row]
        
        cell.capsulesDetailLabel.text = capsule.details != nil ? capsule.details : "unkown"
        cell.capsulesStatus.setTitle(capsule.status, for: .normal)
        
        
        if let status = CapsulesStatus.getStatus(status: capsule.status ?? "unkown") {
            switch status {
            case .active:
                cell.capsulesStatus.backgroundColor = #colorLiteral(red: 0.1527362466, green: 0.5281193256, blue: 0.328921169, alpha: 1)
            case .unkown:
                cell.capsulesStatus.backgroundColor = #colorLiteral(red: 0.8625278473, green: 0.2073233128, blue: 0.2703085542, alpha: 1)
            case .retired:
                cell.capsulesStatus.backgroundColor = #colorLiteral(red: 0.04930239171, green: 0.4321121573, blue: 0.9915542006, alpha: 1)
            case .destroyed:
                cell.capsulesStatus.backgroundColor = #colorLiteral(red: 0.8625278473, green: 0.2073233128, blue: 0.2703085542, alpha: 1)
            }
        }
        
        if let mission = capsule.missions {
            cell.capsulesMissionLabel.text = mission.isEmpty == false ? mission[0].name ?? "" : "unkown"
        }
        
        return cell
    }
}
