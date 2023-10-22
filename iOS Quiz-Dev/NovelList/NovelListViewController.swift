//
//  ViewController.swift
//  iOS Quiz-Dev
//
//  Created by Surachet Yaitammasan on 21/10/23.
//

import UIKit
import Combine

class NovelListViewController: UIViewController {
    @IBOutlet weak var top100NovelTableView: UITableView!
    
    private var novelListViewModel = NovelListViewModel()
    
    private var novelList = [List]()
    private var bannerList = [BannerList]()
    private var currentPage: Int = 1
    
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstSetup()
        getData()
        binding()
    }
    
    private func firstSetup() {
        top100NovelTableView.delegate = self
        top100NovelTableView.dataSource = self
        top100NovelTableView.register(UINib(nibName: "NovelListTableViewCell", bundle: nil), forCellReuseIdentifier: "NovelListTableViewCell")
        top100NovelTableView.register(UINib(nibName: "BannerTableViewCell", bundle: nil), forCellReuseIdentifier: "BannerTableViewCell")
        top100NovelTableView.rowHeight = UITableView.automaticDimension
        top100NovelTableView.estimatedRowHeight = 100
        
        navigationSetup()
    }
    
    private func getData() {
        novelListViewModel.loadMoreNovels(page: currentPage)
        novelListViewModel.getBanners()
    }
    
    private func navigationSetup() {
        self.title = "รายการนิยาย"
    }
    
    private func binding() {
        let _ = novelListViewModel.topNovelList.receive(on: RunLoop.main).sink { [weak self] list in
            guard let self else { return }
            self.novelList.append(contentsOf: list)
            self.top100NovelTableView.reloadData()
        }.store(in: &cancellable)
        
        let _ = novelListViewModel.bannerList.receive(on: RunLoop.main).sink { [weak self] list in
            guard let self else { return }
            self.bannerList = list
            self.top100NovelTableView.reloadData()
        }.store(in: &cancellable)
    }
    
}

extension NovelListViewController: UITableViewDelegate {}

extension NovelListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return novelList.count - 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell", for: indexPath) as! BannerTableViewCell
                cell.configCarousel(bannerList: bannerList)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NovelListTableViewCell", for: indexPath) as! NovelListTableViewCell
                let novelIndex = indexPath.row
                guard novelIndex < novelList.count, let novel = novelList[novelIndex].novel else { return UITableViewCell() }
                cell.config(novelData: novel, ranking: novelIndex + 1)
                cell.config(isTopThree: true)
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NovelListTableViewCell", for: indexPath) as! NovelListTableViewCell
            let novelIndex = indexPath.row + 3
            guard novelIndex < novelList.count, let novel = novelList[novelIndex].novel else { return UITableViewCell() }
            cell.config(novelData: novel, ranking: novelIndex)
            cell.config(isTopThree: false)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == novelList.count - 5  {
            currentPage += 1
            novelListViewModel.loadMoreNovels(page: currentPage)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row \(indexPath.row)")
        print("selected section \(indexPath.section)")
    }
}
