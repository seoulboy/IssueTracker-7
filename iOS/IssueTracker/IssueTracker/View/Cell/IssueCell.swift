//
//  IssueCell.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/05.
//

import UIKit

final class IssueCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let reuseIdentifier = String(describing: IssueCell.self)
    
    // For swipe
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .systemRed
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private let visibleView = IssueCellContentView()
    private var closeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGreen
        return view
    }()
    private var deleteView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemRed
        return view
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView.delegate = self
        setUpView()
        setUpSwipable()
        setUpTapGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        scrollView.delegate = self
        setUpView()
        setUpSwipable()
        setUpTapGesture()
    }

    // MARK: - Method
    
    override func prepareForReuse() {
        visibleView.initLabels()
    }
    
    private func setUpTapGesture() {
        let closeRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeIssue))
        closeView.addGestureRecognizer(closeRecognizer)
        
        let deleteRecognizer = UITapGestureRecognizer(target: self, action: #selector(deleteIssue))
        deleteView.addGestureRecognizer(deleteRecognizer)
    }
    
    
    @objc private func closeIssue() {
        print("close")
    }
    
    
    @objc private func deleteIssue() {
        print("delete")
    }
    
    private func setUpSwipable() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        scrollView.pinEdgesToSuperView()
        stackView.pinEdgesToSuperView()
                
        stackView.addArrangedSubview(visibleView)
        stackView.addArrangedSubview(closeView)
        stackView.addArrangedSubview(deleteView)
        
        visibleView.translatesAutoresizingMaskIntoConstraints = false
        closeView.translatesAutoresizingMaskIntoConstraints = false
        deleteView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.4),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            visibleView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            closeView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.2),
            deleteView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.2)
        ])
        
        addImage(view: closeView, imageName: "xmark.rectangle")
        addImage(view: deleteView, imageName: "trash")
    }
    
    func addImage(view: UIView, imageName: String) {
        let image = UIImage(systemName: imageName)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setUpView() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }

    func configure(issueData: IssueData) {
        visibleView.configure(issueData: issueData)
    }
}


// MARK: - Extension

extension IssueCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = scrollView.contentOffset.x > 0
    }
}


