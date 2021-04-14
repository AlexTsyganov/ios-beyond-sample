//
//  AccountViewModel.swift
//  Demo
//
//  Created by The App Experts on 14/04/2021.
//

import Foundation

protocol AccountViewMdoelProtocal {
    var numerOfAccounts:Int {get}
    func getAccounts(client:NetworkClient)
    func getAccount(for row:Int) -> (name:String, email:String, dob:String, phone:String )
}

class AccountViewModel {
    
    var service:Servicable!
    weak var delegate:AccountViewControllerProtocal!
    
    private var account:Account?
    
    init(accountDelegate:AccountViewControllerProtocal, service:Servicable = Service()) {
        self.delegate = accountDelegate
        self.service = service
    }
}

extension AccountViewModel: AccountViewMdoelProtocal {
    func getAccount(for row: Int) -> (name: String, email: String, dob: String, phone: String) {
        if numerOfAccounts >  row {
            guard   let record = account?.data[row] else {
                return ("", "", "", "")
            }
            return (record[0], record[1], record[2] , record[3]  )
        }
        return ("", "", "", "")
    }
    
   
    
    var numerOfAccounts: Int {
        return account?.data.count ?? 0
    }
    
    
    func getAccounts(client:NetworkClient) {
        service.getData(client: client, type: Account.self) { [weak self] (result) in
            switch result {
            case  .success(let  account):
                self?.account  = account
                DispatchQueue.main.async {
                    self?.delegate.refreshUI()
                }
                
            case  .failure(let error):
                self?.account = nil
                print(error.localizedDescription)
            }
        }
    }
}
