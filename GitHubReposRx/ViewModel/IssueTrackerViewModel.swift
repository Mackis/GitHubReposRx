//
//  IssueTrackerViewModel.swift
//  GitHubReposRx
//
//  Created by Malcolm Kumwenda on 2017/06/14.
//  Copyright © 2017 ByteOrbit. All rights reserved.
//

import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwift


struct IssuetrackerViewModel {
    let provider: RxMoyaProvider<API>
    let repoName: Observable<String>
    
    func trackIssues()-> Observable<[String]> {
        return repoName
            .observeOn(MainScheduler.instance)
            .flatMapLatest { name -> Observable<Repo?> in
                print("Name: \(name)")
                return self.findRepo(name)
            }
            .flatMapLatest { repo -> Observable<[Issue]?> in
                guard let repo = repo else { return Observable.just(nil)}
                print("Repository: \(repo.fullName)")
                return self.findIssues(repo)
            }
            .replaceNilWith([String]())
    }
    
    internal func findIssues(repo: Repo) -> Observable<[Issue]?> {
        return self.provider
            .request(API.issues(repositoryFullName: repo.fullName))
            .debug()
            .mapArrayOptional(type: Issue.self)
    }
    
    internal func findRepo(name: String)-> Observable<Repo?> {
        return self.provider
            .request(API.repo(fullname: name))
            .debug()
            .mapObjectOptional(type: Repo.self)
    }
}
