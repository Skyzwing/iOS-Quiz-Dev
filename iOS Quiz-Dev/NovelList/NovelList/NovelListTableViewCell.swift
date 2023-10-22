//
//  NovelListTableViewCell.swift
//  iOS Quiz-Dev
//
//  Created by Surachet Yaitammasan on 21/10/23.
//

import UIKit
import Combine

class NovelListTableViewCell: UITableViewCell {

    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var contentInsideView: UIView!
    @IBOutlet weak var thumbnameImageView: UIImageView!
    @IBOutlet weak var rankingIconImageView: UIImageView!
    @IBOutlet weak var rankingStackView: UIStackView!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subCategoryLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var chapterIconImageView: UIImageView!
    @IBOutlet weak var chapterAmountLabel: UILabel!
    @IBOutlet weak var redAmountIconImageView: UIImageView!
    @IBOutlet weak var redAmountLabel: UILabel!
    @IBOutlet weak var commentiConImageView: UIImageView!
    @IBOutlet weak var commentAmountLabel: UILabel!
    @IBOutlet weak var descriptionNovelLabel: UILabel!
    @IBOutlet weak var updatedDateLabel: UILabel!
    
    var cancellable: AnyCancellable?
    
    private var tagList: [String]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    
    private func setup() {
        thumbnameImageView.layer.cornerRadius = 16
        subCategoryLabel.textColor = .orange
        ownerLabel.textColor = .gray
        chapterAmountLabel.textColor = .lightGray
        redAmountLabel.textColor = .lightGray
        commentAmountLabel.textColor = .lightGray
        updatedDateLabel.textColor = .lightGray
        
        rankingStackView.layer.borderWidth = 2
        rankingStackView.layer.cornerRadius = 12
        rankingStackView.layer.borderColor = UIColor.orange.cgColor
        
        contentInsideView.layer.cornerRadius = 8


    }
    private func setupCollectionView() {
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
        tagCollectionView.register(UINib(nibName: "TagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagCollectionViewCell")
    }
    
    func config(novelData: Novel, ranking: Int) {
        guard let thumbnail = novelData.thumbnail?.normal else { return }
        if let url = URL(string: thumbnail) {
            thumbnameImageView.setImage(with: url)
        } else {
            thumbnameImageView.image = UIImage(named: "placeholder")
        }
        titleLabel.text = novelData.title
        subCategoryLabel.text = novelData.category?.mainTitle
        ownerLabel.text = novelData.owners?.first?.alias
        chapterAmountLabel.text = novelData.totalChapter?.integerFormattedString()
        redAmountLabel.text = novelData.engagement?.view?.overall?.integerFormattedString()
        commentAmountLabel.text = novelData.engagement?.comment?.overall?.integerFormattedString()
        descriptionNovelLabel.text = novelData.description
        if let date = novelData.updatedAt?.toDate() {
            updatedDateLabel.text = date
        }
        rankingLabel.text = ranking.description
        switch ranking {
        case 1:
            rankingIconImageView.image = UIImage(named: "crown-svgrepo-com")?.withTintColor(.systemYellow)
        case 2:
            rankingIconImageView.image = UIImage(named: "crown-svgrepo-com")?.withTintColor(.gray)
        case 3:
            rankingIconImageView.image = UIImage(named: "crown-svgrepo-com")?.withTintColor(.brown)
        default:
            rankingIconImageView.image = UIImage(named: "crown-svgrepo-com")?.withTintColor(.black)
        }
        tagList = novelData.tags
        setupCollectionView()
        reloadCollectionView()
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.tagCollectionView.reloadData()
        }
    }
    
    func config(isTopThree: Bool = true) {
        rankingIconImageView.isHidden = !isTopThree
    }
    
}

extension NovelListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as? TagCollectionViewCell else {
            return UICollectionViewCell()
            
        }
        guard let tagNovel = tagList?[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.tagLabel.text = "#\(tagNovel)"
        return cell
    }
}

extension NovelListTableViewCell: UICollectionViewDelegate {}

