//
//  ViewController.swift
//  ToDoList
//
//  Created by Allexia Azevedo de Morais on 13/08/21.
//

import UIKit

protocol NewItem {
    //Enter new to do list item
    func enterNewItem(string: String)
}

class ToDoListItem {
    @objc dynamic var item: String = ""
    @objc dynamic var date: Date = Date()
}

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.data = UserDefaults.standard.stringArray(forKey: "ïtems") ?? []
        title = "To Do List"
        view.addSubview(table)
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAdd))
        
    }
    
    
    
    @objc private func didTapAdd() {
        
        let rootVC = NewCellPage()
        rootVC.delegate = self
        navigationController?.pushViewController(rootVC, animated: true)
        
//        let navVC = UINavigationController(rootViewController: rootVC)
//
//        present(navVC, animated: true)
//        let alert = UIAlertController(title: "Nova Tarefa",
//                                      message: "Insira uma nova tarefa",
//                                      preferredStyle: .alert)
//        alert.addTextField(configurationHandler: { field in
//            field.placeholder = "Nova Tarefa"
//
//        })
//
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] (_) in
//            if let field = alert.textFields?.first {
//                if let text = field.text, !text.isEmpty{
//                    //Enter new to do list item
//                    DispatchQueue.main.async {
//                        var currentItems =  UserDefaults.standard.stringArray(forKey: "ïtems") ?? []
//                        currentItems.append(text)
//                        UserDefaults.standard.setValue(currentItems, forKey: "items")
//                        self?.data.append(text)
//                        self?.table.reloadData()
//                    }
//                }
//            }
//        }))
//
//        present(alert, animated: true)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath) as UITableViewCell
        cell.textLabel?.text = data[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func texFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//    func refresh {
//
//    }


}

extension ViewController: NewCellPageDelegate {
    func newCellPageDidTapComfirm(itemName: String, itemDateAndTime: String) {
            
        self.data.append(itemName + ", " + itemDateAndTime)
        self.table.reloadData()
            
    }
    
    
}
