//
//  ViewController.swift
//  SimpleCloudKit
//
//  Created by Muhammad Syabran on 02/09/20.
//  Copyright © 2020 ADA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items:[Reflection]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchReflection()
    }

    func fetchReflection() {
        
        do {
            self.items = try context.fetch(Reflection.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData() // Reload table view
            }
    }
        catch {
            print(error)
        }
    }

    @IBAction func addTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add Reflection", message: "what are your reflection today?", preferredStyle: .alert)
        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
        guard let textField = alert.textFields?[0] else {return}
            let learned = textField.text ?? ""
            
            let newReflect = Reflection(context: self.context)
            newReflect.learned = learned
            newReflect.date = 1
            
            do {
                try self.context.save()
                print("Record Saved")
            } catch {
                print(error)
            }
            
            self.fetchReflection()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")
    
        let reflect = self.items![indexPath.row]
    
        cell?.textLabel?.text = reflect.learned
    
        return cell!
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
           
            let removeReflect = self.items![indexPath.row]
            self.context.delete(removeReflect)
            
            do {
                try self.context.save()
                print("Record Saved")
            } catch {
                print(error)
            }
            self.fetchReflection()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let reflect = self.items![indexPath.row]
            
            // Create alert
            let alert = UIAlertController(title: "Edit Reflection", message: "Edit what you learned:", preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.text = reflect.learned
            }
            
            let saveButton = UIAlertAction(title: "Save", style: .destructive) { (action) in
                
                guard let textField = alert.textFields?[0] else {return}
                reflect.learned = textField.text ?? ""
                
                // Save the data
                do {
                    try self.context.save()
                    print("Record Saved")
                } catch {
                    print(error)
                }
                
                self.fetchReflection()
            }
            
            // Add Button
            alert.addAction(saveButton)
            
            // Show alert
            self.present(alert, animated: true, completion: nil)
        }
}
