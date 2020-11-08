//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/10/29.
//

import UIKit

final class IssueListViewController: UIViewController {
   
    // MARK: - Property
    
    @IBOutlet private var collectionView: UICollectionView!
    private var issueDataList: [IssueInfo] = []
    private let api = BackEndAPIManager(router: MockRouter())
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.layoutIfNeeded()
        configureLayout()
        
        setUpIssueData()
    }
    
    
    // MARK: - Method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "IssueListToFilter" {
            guard let navigationController = segue.destination as? UINavigationController,
                  let viewController = navigationController.topViewController as? FilteringController
            else { return }
            
            viewController.preDefinedConditionHandler = { conditions in
//                BackEndAPIManager.shared.requestFiltering(conditions: conditions) { (result: Result<이슈목록Decodable객체, APIError>) in
//
//                }
                print("predefinedConditionHandler") //
            }
            viewController.detailConditionHandler = { conditions in
//                BackEndAPIManager.shared.requestFiltering(conditions: conditions) { (result: Result<이슈목록Decodable객체, APIError>) in
//                    
//                }
                print("detailConditionHandler")
            }
        }
    }
}


// MARK: - Extension

extension IssueListViewController {
    
    private func setUpIssueData() {
        api.requestAllIssues() { result in
            switch result {
            case .success(let issues):
                self.issueDataList = issues
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureLayout() {
        let spacing: CGFloat = 10
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.estimatedItemSize = CGSize(width: collectionView.frame.width-30, height: 50)
        collectionViewFlowLayout.headerReferenceSize = CGSize(width: collectionView.frame.width, height: 50)
        collectionViewFlowLayout.minimumLineSpacing = spacing
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: spacing, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = collectionViewFlowLayout
    }
}

extension IssueListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return issueDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IssueCell.reuseIdentifier, for: indexPath) as! IssueCell
        cell.configure(issueData: issueDataList[indexPath.row])
        
        return cell
    }
}

extension IssueListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailIssueList", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "DetailIssueListController")
        
        navigationController?.pushViewController(viewController, animated: true)

    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "searchBarHeader",
                for: indexPath)
        
        return headerView

    }
}

extension IssueListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("입력")
    }
}


