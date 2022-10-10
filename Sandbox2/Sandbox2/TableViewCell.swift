//
//  TableViewCell.swift
//  Sandbox2
//
//  Created by Suharik on 14.09.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifire = "PostTableViewCell"
    private lazy var imageVIew: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageVIew)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            imageVIew.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageVIew.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageVIew.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            imageVIew.widthAnchor.constraint(equalToConstant: 70),
            imageVIew.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

