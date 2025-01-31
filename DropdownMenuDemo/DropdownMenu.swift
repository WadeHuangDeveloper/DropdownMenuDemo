//
//  DropdownMenu.swift
//  DropdownMenuDemo
//
//  Created by Huei-Der Huang on 2025/1/31.
//

import UIKit

protocol DropdownMenuDelegate: AnyObject {
    func dropdownMenu(_ menu: DropdownMenu, didSelectItem item: String, at index: Int)
}

protocol DropdownMenuDataSource: AnyObject {
    func numberOfItems(in menu: DropdownMenu) -> Int
    func dropdownMenu(_ menu: DropdownMenu, itemAt index: Int) -> String
}

class DropdownMenu: UIView {
    weak var delegate: DropdownMenuDelegate?
    weak var dataSource: DropdownMenuDataSource?
    private var tableView = UITableView()
    private let identifier = "DropdownMenuIdentifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 5
        backgroundColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        tableView.layer.cornerRadius = 5
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(tableView)
    }
    
    func show() {
        let itemCount = dataSource?.numberOfItems(in: self) ?? 0
        let height = CGFloat(min(itemCount, 5)) * 50
        
        UIView.animate(withDuration: 0.2) {
            self.frame.size.height = height
            self.tableView.frame = self.bounds
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.2) {
            self.frame.size.height = 0
            self.tableView.frame.size.height = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
}

extension DropdownMenu: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.numberOfItems(in: self) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let item = dataSource?.dropdownMenu(self, itemAt: indexPath.row) ?? ""
        cell.textLabel?.text = item
        cell.selectionStyle = .none
        return cell
    }
}

extension DropdownMenu: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = dataSource?.dropdownMenu(self, itemAt: indexPath.row) ?? ""
        delegate?.dropdownMenu(self, didSelectItem: selectedItem, at: indexPath.row)
        hide()
    }
}
