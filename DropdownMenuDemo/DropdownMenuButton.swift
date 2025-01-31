//
//  DropdownMenuButton.swift
//  DropdownMenuDemo
//
//  Created by Huei-Der Huang on 2025/1/30.
//

import UIKit

class DropdownMenuButton: UIButton {
    var dropdownMenu = DropdownMenu()
    private var trailingImageView = UIImageView()
    private let identifier = "DropdownMenuButtonIdentifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        trailingImageView.image = UIImage(systemName: "chevron.down")!
        trailingImageView.tintColor = .black
        trailingImageView.contentMode = .scaleAspectFit
        trailingImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(trailingImageView)
        addTarget(self, action: #selector(onTouchUpInside), for: .touchUpInside)
        setTitleColor(.black, for: .normal)
        contentHorizontalAlignment = .leading
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 5
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            trailingImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            trailingImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            trailingImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            trailingImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    @objc private func onTouchUpInside() {
        if dropdownMenu.superview != nil {
            dropdownMenu.hide()
        } else {
            showDropdownMenu()
        }
    }
    
    private func showDropdownMenu() {
        guard let parentView = self.superview else { return }
        
        dropdownMenu.frame = CGRect(x: frame.origin.x, y: frame.maxY + 5, width: frame.width, height: 0)
        parentView.addSubview(dropdownMenu)
        dropdownMenu.show()
    }
}
