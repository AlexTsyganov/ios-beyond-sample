//
//  AccountViewController.swift
//  Demo
//
//  Created by The App Experts on 14/04/2021.
//

import UIKit


protocol AccountViewControllerProtocal: class {
    func refreshUI()
}
class AccountViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var accountViewModel:AccountViewMdoelProtocal!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountViewModel = AccountViewModel(accountDelegate: self)
        accountViewModel.getAccounts(client:  NetworkClient(baseUrl:"https://beyond-sample.yams.brandwidth.com/", path: "list"))
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountViewModel.numerOfAccounts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard   let cell = tableView.dequeueReusableCell(withIdentifier:"accountTableViewCell") as? AccountTableViewCell else  {
            return UITableViewCell()
        }
        let record = accountViewModel.getAccount(for: indexPath.row)
        cell.setData(account: record)
       
        return cell
    }
    
    
}


extension AccountViewController: UITableViewDelegate {
}

extension AccountViewController: AccountViewControllerProtocal {
    func refreshUI() {
        tableView.reloadData()
    }
}

