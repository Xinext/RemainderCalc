//
//  HistoryTableViewController.swift
//  RemainderCalc
//


import UIKit

class HistoryTableViewController: UITableViewController {

    // MARK: - IBOutlet
    @IBOutlet var outletTableView: UITableView!
    
    var dataList: Array<D_History>? = nil
    
    // MARK: - UITableViewController Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // タイトルの設定
        self.navigationItem.title = NSLocalizedString("STR_HISTORY_VIEW_TITLE", comment: "")
        
        // 表示データの取得
        dataList = ModelMgr.Load_D_History()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ModelMgr.GetCount_D_History()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "ResultCell")
        cell.textLabel?.text = (dataList?[indexPath.row].m_i_expression)! + " = " + (dataList?[indexPath.row].m_i_answer)!
        
        return cell
        
    }

}
