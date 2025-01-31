//
//  ViewController.swift
//  DropdownMenuDemo
//
//  Created by Huei-Der Huang on 2025/1/30.
//

import UIKit

class ViewController: UIViewController {
    private var dropdownMenuButton = DropdownMenuButton()
    private let companyItems: [String] = ["Apple", "Nvidia", "Microsoft"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initUI()
    }

    private func initUI() {
        dropdownMenuButton.setTitle(companyItems[0], for: .normal)
        dropdownMenuButton.dropdownMenu.dataSource = self
        dropdownMenuButton.dropdownMenu.delegate = self
        dropdownMenuButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(dropdownMenuButton)
        
        NSLayoutConstraint.activate([
            dropdownMenuButton.widthAnchor.constraint(equalToConstant: 200),
            dropdownMenuButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dropdownMenuButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -80),
        ])
    }
}

extension ViewController: DropdownMenuDataSource {
    func numberOfItems(in menu: DropdownMenu) -> Int {
        return companyItems.count
    }
    
    func dropdownMenu(_ menu: DropdownMenu, itemAt index: Int) -> String {
        return companyItems[index]
    }
}

extension ViewController: DropdownMenuDelegate {
    func dropdownMenu(_ button: DropdownMenu, didSelectItem item: String, at index: Int) {
        print(item)
    }
}
