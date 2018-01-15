//
//  ViewController.swift
//  RearrangeCollectionViews
//
//  Created by Apple on 15/01/18.
//  Copyright © 2018 WowDreamapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var arrayItems = [Int]()
    var stories = ["Then it cannot be your own true nature, said the teacher, “if it were, you would be able to show it to me at any time." ,
        "Why are you allowing something that is not yours to trouble your life?",
        "Right now I cannot show it to you.",
        "You have something very strange, said the master",
        "A Zen student said to his master, “Master, I have an ungovernable temper. Help me get rid of it",
        "Why not?",
        "Show it to me., asked the Zen Master",
        "In time, he developed a calm and placid temperament.",
        "Thereafter whenever the student felt his temper rising he remembered his master's words and checked his anger.",
        "It arises suddenly",
        "Moral: OverComing anger"
        ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for value in 0...20 {
            arrayItems.append(value)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        configureCollectionView()
        
    }
    
    func configureCollectionView() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(reArrangeItems(gesture:)))
        self.collectionView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func reArrangeItems(gesture: UILongPressGestureRecognizer) {
        switch (gesture.state) {
        case .began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {break}
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    
}
extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    //Data Source Methods:
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! StoriesCell
        cell.titleLabel.text = stories[indexPath.item]
        return cell
    }
    
    //Delegate Methods:
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let newLocation = stories.remove(at: sourceIndexPath.item)
        stories.insert(newLocation, at: destinationIndexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        if indexPath.item % 2 == 0 {
            return true
        }else {
            return true
        }
        
    }
    
    
}
