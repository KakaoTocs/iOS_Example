//
//  ViewController.swift
//  CollectionView
//
//  Created by Kim on 2018. 5. 29..
//  Copyright © 2018년 Kim. All rights reserved.
// 참고 사이트: http://rshankar.com/uicollectionview-demo-in-swift/

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let identifier = "cell"
    let headerViewIdentifier = "header"
    let dataSource = DataSource()
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 선택된 섹션의 셀 indexPath 반환
    func getIndexPathForSelectedCell() -> IndexPath? {
        var indexPath: IndexPath?
        if (collectionView.indexPathsForSelectedItems?.count)! > 0 {
            indexPath = collectionView.indexPathsForSelectedItems![0] as? IndexPath
        }
        return indexPath
    }
    
    // 해더 생성부
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView: ProgramHeaderReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewIdentifier, for: indexPath) as! ProgramHeaderReusableView
        headerView.sectionLabel.text = dataSource.getGroupLabelAtIndex(index: indexPath.section)
        
        headerView.tag = indexPath.section
        
        headerView.isUserInteractionEnabled = true
        headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerTapped)))
        
        return headerView
    }
    
    // 섹션의 수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.groupHardDisk.count
    }
    
    // 섹션의 셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfRowsInEachGroup(index: section)
    }
    
    // 셀 생성부
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CollectionViewCell
        
        let programs: [Program] = dataSource.programsInGroup(index: indexPath.section)
        let program = programs[indexPath.row]
        let name = program.name!

        cell.imageView.image = UIImage(named: name)
        cell.textView.text = name
        
        return cell
    }
    
    @objc func headerTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if let section = sender.view?.tag {
                print(section)
                dataSource.groupMemory.remove(at: section)
                self.collectionView.reloadData()
            }
        }
    }
    
    // 상세 보기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = getIndexPathForSelectedCell() {
            let program = dataSource.programsInGroup(index: indexPath.section)[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.program = program
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

