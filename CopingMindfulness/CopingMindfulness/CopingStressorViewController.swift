//
//  CopingStressorViewController.swift
//  CopingMindfulness
//
//  Created by 川守田敦史 1 on 2016/06/21.
//  Copyright © 2016年 Atsushi Kawamorita. All rights reserved.
//

import UIKit
import CoreData

class CopingStressorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var BarButtonAdd: UIBarButtonItem!
    @IBOutlet weak var tableViewStressorList: UITableView!
    
    var tableData: Array<String> = Array<String>()
    var insertCount: Int32 = 1
    override func viewDidLoad() {
        tableViewStressorList.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableViewStressorList.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func SearchData() -> Array<String>{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let fetchRequest = NSFetchRequest(entityName: "StressorContents")
        var returnValue: Array<String> = Array<String>()
        do{
            let contents = try appDelegate.managedObjectContext.fetch(fetchRequest) as! [StressorContents]
            for content in contents{
                returnValue.append(content.stressorData!)
            }
        }catch let error as NSError {
            print(error)
        }
        return returnValue
    }
    
    @IBAction func addData(_ sender: AnyObject) {
        let alert = UIAlertController(title: "New Name",message: "Add a new name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { (action:UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            self.tableData.append(textField!.text!)
            self.saveNewData(NSDecimalNumber.init(value: self.insertCount as Int32), target: textField!.text!)
            self.tableViewStressorList.reloadData()
            self.insertCount += 1
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",style: .default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextField {(textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert,animated: true,completion: nil)
    }
    
    func saveNewData(_ id: NSDecimalNumber, target: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let stressor = NSEntityDescription.insertNewObject(forEntityName: "StressorContents", into: appDelegate.managedObjectContext) as! StressorContents
        stressor.stressorId = id
        stressor.stressorData = target
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell!.textLabel!.text = tableData[(indexPath as NSIndexPath).row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
}
