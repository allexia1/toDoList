//
//  NewCellPage.swift
//  ToDoList
//
//  Created by Allexia Azevedo de Morais on 18/08/21.
//

import UIKit

public protocol NewCellPageDelegate: AnyObject {
    func newCellPageDidTapComfirm(itemName: String, itemDateAndTime: String)
}

class NewCellPage: UIViewController, UITextFieldDelegate {
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [toDoItem,
                                                       dateAndTime])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var toDoItem: UITextField = {
       let textField = UITextField()
        textField.becomeFirstResponder()
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 8
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.placeholder = "  Insira a tarefa"
        textField.delegate = self
        
        return textField
    }()
    
//    var textField = UITextField(frame: CGRect(x: 10.0, y: 100.0, width: UIScreen.main.bounds.size.width - 20.0, height: 50.0))
//    private lazy var datePicker:UIDatePicker {
//       return
//    }()
    
    private lazy var dateAndTime: UITextField = {
       let date = UITextField()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.placeholder = "Coloque a data da tarefa"
        date.font = UIFont.systemFont(ofSize: 15)
        date.borderStyle = .roundedRect
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        date.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(self.valueChanged), for: .valueChanged)
        
        return date
    }()
    
    
    public var completionHendler: (() -> Void)?
    weak var delegate: NewCellPageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "To Do List", style: .done, target: self, action: #selector(backTableView))
        //self.view.addSubview(textField)
        setupUIConstraint()
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    @objc func didTapSave() {
        guard let newToDoItem = toDoItem.text,
              let newDateAndTimeItem = dateAndTime.text else{
                return
        }
        
        delegate?.newCellPageDidTapComfirm(itemName: newToDoItem, itemDateAndTime: newDateAndTimeItem)
        navigationController?.popViewController(animated: true)
    }
//        if let field = toDo {
//            if let text = field.text, !text.isEmpty{
//                //Enter new to do list item
//                DispatchQueue.main.async {
//                var currentItems =  UserDefaults.standard.stringArray(forKey: "ïtems") ?? []
//                currentItems.append(text)
//                UserDefaults.standard.setValue(currentItems, forKey: "items")
//                    self.data.append(text)
//                    self.table.reloadData()
//                            }
//                        }
//                    }
  //  }
        
//        DispatchQueue.main.sync {
//        var currentItems =  UserDefaults.standard.stringArray(forKey: "ïtems") ?? []
//        currentItems.append(text)
//        UserDefaults.standard.setValue(currentItems, forKey: "items")
//        self?.data.append(text)
//        self?.table.reloadData()
//    
//        }
//    }
//        
    
    
    @objc func valueChanged(sender: UIDatePicker){
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .long
        dateFormat.timeStyle = .long
        self.dateAndTime.text = dateFormat.string(from: sender.date)
    }
    
    private func setupUIConstraint() {
        view.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120)
        ])
    }
    
    @objc func backTableView() {
        navigationController?.popViewController(animated: true)
        
    }
    
}
