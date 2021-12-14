//
//  ViewController.swift
//  spaceX
//
//  Created by Cem Nisan on 10.12.2021.
//

import UIKit

protocol ICapsulesViewController: AnyObject {
    func showCapsules(capsules: [Capsules])
    func showError(error: NetworkError)
}

class CapsulesViewController: UIViewController {
    
    @IBOutlet weak var capsulesTableView: UITableView!
    
    private var capsules:[Capsules] = []
    
    private lazy var capsulesViewModel: CapsulesViewModel = {
        return CapsulesViewModel(networkService: NetworkService(), delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        capsulesTableView.dataSource = self
        capsulesTableView.register(UINib(nibName: K.App.nibName, bundle: nil), forCellReuseIdentifier: K.App.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        capsulesViewModel.fetchCapsules()
    }
    
    @IBAction func segmentPressed(_ sender: UISegmentedControl) {
        guard let segmentTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) else { return }
       
        switch segmentTitle {
        case K.SegmentTitle.allCapsules.rawValue:
            capsulesViewModel.fetchCapsules()
            
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
    
    func showCapsules(capsules: [Capsules]) {
        DispatchQueue.main.async {
            self.capsules = capsules
            self.capsulesTableView.reloadData()
        }
    }
    
    func showError(error: NetworkError) {
        print(error) 
    }
}

extension CapsulesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.capsules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = capsulesTableView.dequeueReusableCell(withIdentifier: K.App.reuseIdentifier, for: indexPath) as! CapsulesTableViewCell
        let capsule = capsules[indexPath.row]
        
        cell.capsulesDetailLabel.text = capsule.details != nil ? capsule.details : "unkown"
        cell.capsulesStatus.setTitle(capsule.status, for: .normal)
        
        if let tmp = capsule.missions {
            cell.capsulesMissionLabel.text = tmp.isEmpty == false ? tmp[0].name ?? "" : "unkown"
        }
        
        return cell
    }
}
