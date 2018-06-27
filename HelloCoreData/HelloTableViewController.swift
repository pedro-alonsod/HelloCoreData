//
//  HelloTableViewController.swift
//  HelloCoreData
//
//  Created by Pedro Alonso on 6/27/18.
//  Copyright © 2018 Pedro Alonso. All rights reserved.
//

import UIKit

class HelloTableViewController: UITableViewController {

//    var helloCD: [Hello]? = nil
    var helloCDArray: [HelloCD] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        getHello()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        getHello()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return helloCDArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let cell = UITableViewCell()
        
        if let name = helloCDArray[indexPath.row].name {
            cell.textLabel?.text = name
        }
        
        // Configure the cell...

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chosenHello = helloCDArray[indexPath.row]
        
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
//        if let todo = toDo {
        context.delete(chosenHello)
        
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        getHello()

//        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        
//        if let name = txtName.text {
            //            let newToDo = ToDo(name: name, important: self.swcImportant.isOn)
            let newHello = HelloCD(context: context)
            
//            newToDo.important = self.swcImportant.isOn
            newHello.name = "Hello!"
        
            //            toDoTableVC?.toDos.append(newToDo)
            //            toDoTableVC?.tableView.reloadData()
            
            // MARK: Save data into CD
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            getHello()
//            tableView.reloadData()
//            self.viewWillAppear(true)

//            self.navigationController?.popViewController(animated: true) // with a NavigatinController
//        }
    }
    
    func getHello() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        
        if let hello = try? context.fetch(HelloCD.fetchRequest()) {
            
            if let helloReturned = hello as? [HelloCD] {
                print(helloReturned)
                
                helloCDArray = helloReturned
                tableView.reloadData()
            }
        }
    }
    
}
