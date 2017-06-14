//
//  MainVC.swift
//  GitHubReposRx
//
//  Created by Malcolm Kumwenda on 2017/06/14.
//  Copyright © 2017 ByteOrbit. All rights reserved.
//

import Moya
import Moya_ModelMapper
import UIKit
import RxCocoa
import RxSwift

class MainVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    var provider: RxMoyaProvider<API>!
    var latestReposName: Observable<String> {
        return searchBar.rx
            .text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    func setupRx(){
        provider = RxMoyaProvider<API>()
        
        tableView.rx
            .itemSelected
            .subscribe({_ in 
                if self.searchBar.isFirstResponder == true {
                    self.view.endEditing(true)
                }
            }).addDisposableTo(disposeBag)
    }
}
