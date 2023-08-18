//
//  CollectionCharactersCell.swift
//  RikAndMortyAPIUIKitSwiftUI
//
//  Created by Валерия Дементьева on 18.08.2023.
//

import Foundation
import UIKit

class CollectionCharactersCell: UICollectionViewCell {

    static let identifier = "cell"

    //MARK: - Properties
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.tintColor = .white
        return label
    }()

    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Hierarchy
    private func setupHierarchy() {
        addSubview(stack)
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(nameLabel)
    }

    //MARK: - Layout
    private func setupLayout() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: topAnchor,constant: 5).isActive = true
        stack.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5).isActive = true
        stack.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -5).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -5).isActive = true
    }
}//finish class
