//
//  NovelListViewModel.swift
//  iOS Quiz-Dev
//
//  Created by Surachet Yaitammasan on 21/10/23.
//

import Foundation
import Combine

class NovelListViewModel {
    var topNovelList = CurrentValueSubject<[List], Never>([])
    var bannerList = CurrentValueSubject<[BannerList], Never>([])
    
    private var cancellables = Set<AnyCancellable>()
    
    private let service = ServiceManager.shared
    
    func getNovel(page: Int) {
        let _ = service.call(endpoint: .topNovelList(page: page), type: TopNovelList.self).sink { completion in
            switch completion {
            case .failure(let error):
                print("Error is \(error.localizedDescription)")
            case .finished:
                print("Get data Success")
            }
        } receiveValue: { [weak self] response in
            guard let self, let list = response.list else { return }
            self.topNovelList.send(list)
        }.store(in: &cancellables)
    }
    
    func getBanners() {
        let _ = service.call(endpoint: .banner, type: Banner.self).sink { completion in
            switch completion {
            case .failure(let error):
                print("Error is \(error.localizedDescription)")
            case .finished:
                print("Get banner success")
            }
        } receiveValue: { [weak self] response in
            guard let self, let list = response.list else { return }
            self.bannerList.send(list)
        }.store(in: &cancellables)
    }
    
    func loadMoreNovels(page: Int) {
        getNovel(page: page)
    }
}
