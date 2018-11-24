//
//  WallCollectionViewController.swift
//  ACollection
//
//  Created by Ajumal Ebrahim on 11/22/18.
//  Copyright © 2018 Ajumal Ebrahim. All rights reserved.
//

import UIKit
import MBProgressHUD

class WallCollectionViewController: UICollectionViewController {

    var walls = [WallElement]()
    var refresher: UIRefreshControl!
    let model = WallModel()
    
    var hud = MBProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.collectionView!.refreshControl = refresher
//
        // Register cell classes
        self.collectionView!.register(WallViewCell.nib, forCellWithReuseIdentifier: WallViewCell.identifier)
        
        // Call api
        model.delegate = self
        model.getWallData()
        showHud()
    }
    
    @objc fileprivate func loadData() {
        self.collectionView!.refreshControl?.beginRefreshing()
        model.getWallData()
        showHud()
    }
    
    fileprivate func stopRefresher() {
        self.collectionView!.refreshControl?.endRefreshing()
        self.refresher.endRefreshing()
    }
    
    private func showHud() {
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .annularDeterminate
        hud.label.text = "Loading"
    }

}

// MARK: WallModelDelegate

extension WallCollectionViewController: WallModelDelegate {
    func wallApicompleted(_ result: [WallElement]) {
        if result.count > 0 {
            walls = result
        }
        DispatchQueue.main.async {
            self.stopRefresher()
            self.collectionView.reloadData()
            self.hud.hide(animated: true)
        }
    }
}

// MARK: UICollectionViewDataSource

extension WallCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return walls.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WallViewCell.identifier, for: indexPath) as? WallViewCell else {
            return WallViewCell()
        }
        
        // Configure the cell
        let element: WallElement = walls[indexPath.row]
        cell.updateCellData(element)
        return cell
    }
    
    
}
