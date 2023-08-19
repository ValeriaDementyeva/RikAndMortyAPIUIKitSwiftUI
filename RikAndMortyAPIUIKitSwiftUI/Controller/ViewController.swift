//
//  ViewController.swift
//  RikAndMortyAPIUIKitSwiftUI
//
//  Created by Валерия Дементьева on 17.08.2023.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    //MARK: - Properties
    private var characters: [CharactersModelElement] = []

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionCharactersCell.self, forCellWithReuseIdentifier: CollectionCharactersCell.identifier)
        collectionView.backgroundColor = UIColor(red: 0.013, green: 0.048, blue: 0.119, alpha: 1)
        return collectionView
    }()

    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsNavigation()
        setupHierarchy()
        setupLayout()

        APIManager.shared.getCharacters { characters in
            DispatchQueue.main.async {
                self.characters = characters
                self.collectionView.reloadData()
                for character in characters {
                    print("Character name: \(character.name)")
                    print("Character name: \(character.image)")
                }
            }
        }
    }
    //MARK: - Navigation
    private func settingsNavigation() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Characters"
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 27, weight: .bold),
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = titleAttributes
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
    }

    private func navigationSwiftUiInUikit() {
        let detailScreenInfoController = DetailScreenInfoController()

        let hostingController = UIHostingController(rootView: detailScreenInfoController)

        navigationController?.pushViewController(hostingController, animated: true)
    }

    //MARK: - Hierarchy
    private func setupHierarchy() {
        view.addSubview(collectionView)
    }

    //MARK: - Layout
    private func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.75))

            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

            let groupSize = NSCollectionLayoutSize( widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))

            let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [layoutItem])

            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 10, bottom: 10, trailing: 10)

            return layoutSection
        }
    }
}//final class

//MARK: - Extension ViewController
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCharactersCell.identifier, for: indexPath) as! CollectionCharactersCell

        cell.backgroundColor = UIColor(red: 0.149, green: 0.165, blue: 0.22, alpha: 1)
        cell.layer.cornerRadius = 15

        let character = characters[indexPath.item]
        cell.nameLabel.text = character.name

        if let imageURL = URL(string: character.image) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        cell.image.image = UIImage(data: imageData)
                    }
                }
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationSwiftUiInUikit()
    }
}

