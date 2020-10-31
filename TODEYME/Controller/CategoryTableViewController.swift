//
//  CategoryTableViewController.swift
//  TODEYME
//
//  Created by Ashish Pandey on 31/10/20.
//  Copyright © 2020 Simmy Pandey. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categoryArray = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
          print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCategoryCell", for: indexPath)

        let category = categoryArray[indexPath.row]
             
        cell.textLabel?.text = category.name
       
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "GoToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListTableViewController
        if let indexpath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categoryArray[indexpath.row]
        }
    }
    

    @IBAction func addButton_Pressed(_ sender: Any) {
           
           var textField = UITextField()
           
           let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
               
               
            let newCategory = Category(context: self.context)
                newCategory.name = textField.text!
               
               self.categoryArray.append(newCategory)
               self.saveCategories()
               
           }
           
           alert.addTextField { (alertTextfield) in
               alertTextfield.placeholder = "Add Category"
               textField = alertTextfield
           }
           
           alert.addAction(action)
           present(alert, animated: true, completion: nil)
       }
       
    
    
    func saveCategories() {
        
        do {
            try context.save()
            
           } catch {
            
            print("Error \(error)")
            }
         tableView.reloadData()
       }
    
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
           categoryArray =  try context.fetch(request)
        } catch {
             print("Error \(error)")
        }
        
        tableView.reloadData()
    }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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


