//
//  BannerTableViewCell.swift
//  iOS Quiz-Dev
//
//  Created by Surachet Yaitammasan on 22/10/23.
//

import UIKit

class BannerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    private var bannerList = [BannerList]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
//        configureCellSize()
    }
    
    private func setup() {
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        bannerCollectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCell")
    }
    
    func configCarousel(bannerList: [BannerList]) {
        self.bannerList = bannerList
        bannerCollectionView.reloadData()
    }
    
//    func configureCellSize(){
//        if let layout = bannerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
//            layout.scrollDirection = .horizontal
//        }
//    }
}


extension BannerTableViewCell: UICollectionViewDelegate {}

extension BannerTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bannerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configImage(image: bannerList[indexPath.row].payload?.imageURL?.mobile)
        return cell
    }
}

extension BannerTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return bannerCollectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
