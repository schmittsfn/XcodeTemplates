//___FILEHEADER___

import Foundation
import UIKit

/// A viewController containing a collectionView responsible for X
final class ___FILEBASENAMEASIDENTIFIER___: UIViewController {
    
    // MARK: - Typealiases
    private typealias Datasource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    // MARK: - Enums
    private enum Section: CaseIterable {
        case main
    }
    
    private enum Row: Hashable {
        case __devBuildAndTestLayout(Int) // remove me once completed
    }
    
    // MARK: - Fields
    private weak var collectionView: UICollectionView!
    private var dataSource: Datasource! = nil
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDatasource()
    }
    
    // MARK: - Setup
    /// Set up this viewcontroller's view hierarchy
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        view.addSubview(collectionView)
        self.collectionView = collectionView
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Using SnapKit -- remove if not needed
//        collectionView.snp.makeConstraints({ make in
//            make.edges.equalToSuperview()
//        })
    }
    
    /// Sets up the datasource
    private func setupDatasource() {
        let __devTextCellRegistration = __DevTextCell.devTextCellRegistration()
        
        let dataSource = Datasource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Row) -> UICollectionViewCell? in
            
            switch item {
            case .__devBuildAndTestLayout(let integer):
                return collectionView.dequeueConfiguredReusableCell(using: __devTextCellRegistration, for: indexPath, item: integer)
            }
        }
        
        self.dataSource = dataSource
        collectionView.collectionViewLayout = createLayout(dataSource: dataSource)
        
        var initialSnapshot = Snapshot()
        initialSnapshot.appendSections(Section.allCases)
        initialSnapshot.appendItems(Array(0...4).map({ Row.__devBuildAndTestLayout($0) }), toSection: .main)
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    /// Creates the layout for the collectionView
    /// - Parameter dataSource: The datasource to use as reference for section layouts
    /// - Returns: The layout to use for the collectionView
    private func createLayout(dataSource: Datasource) -> UICollectionViewLayout {

        let layout = UICollectionViewCompositionalLayout(sectionProvider: {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section = dataSource.sectionIdentifier(for: sectionIndex)
            switch section {
            case .main:
                // Item
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // Group
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16)
                
                return NSCollectionLayoutSection(group: group)
                
            case .none:
                assertionFailure()
                return nil
            }
        })
        
        return layout
    }
}









// MARK: - __DEV - remove me
fileprivate final class __DevTextCell: UICollectionViewCell {
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
}
fileprivate extension __DevTextCell {
    func configure() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        contentView.addSubview(label)
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        let inset = CGFloat(8)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
    
    static func devTextCellRegistration() -> UICollectionView.CellRegistration<__DevTextCell, Int> {
        return UICollectionView.CellRegistration<__DevTextCell, Int> { (cell, indexPath, integer) in
            cell.label.text = "\(integer)"
            cell.contentView.backgroundColor = .blue
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.cornerRadius = 8
            cell.label.textAlignment = .center
            cell.label.font = UIFont.preferredFont(forTextStyle: .title1)
        }
    }
}
