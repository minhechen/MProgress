//
//  ViewController.swift
//  MProgressDemo
//
//  Created by mchen on 2022/3/23.
//

import UIKit
import MProgress

class ViewController: UIViewController {

    var progresses: [ProgressType] = [ProgressType]()

    lazy var contentHeight: CGFloat = {
        let contentHeight = UIScreen.main.bounds.height - self.view.safeAreaInsets.top - self.view.safeAreaInsets.bottom
        return contentHeight
    }()

    lazy var flowlayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 8
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.cellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.semanticContentAttribute = UIView.appearance().semanticContentAttribute
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupData()
        self.setupUI()
    }

    func setupData() {
        progresses.append(.plane)
        progresses.append(.chase)
        progresses.append(.bounce)
        progresses.append(.wave)
        progresses.append(.pulse)
        progresses.append(.flow)
        progresses.append(.swing)
        progresses.append(.circle)
        progresses.append(.fade)
        progresses.append(.grid)
        progresses.append(.fold)
        progresses.append(.wander)
        progresses.append(.pendulum)
        progresses.append(.loopCircle)
    }

    func setupUI() {
        self.view.addSubview(collectionView)
        let topPadding = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 20
        collectionView.frame = CGRect(x: 12, y: topPadding, width: self.view.frame.width - 24, height: contentHeight)
    }
}

extension ViewController: UICollectionViewDelegate {


}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return progresses.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.cellID, for: indexPath)
        if let cell = cell as? ProgressCollectionViewCell {
            let progress = progresses[indexPath.row]
            cell.setupContent(progress)
        }
        return cell
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (UIScreen.main.bounds.width - 72) / 4
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
