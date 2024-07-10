//
//  AddTransactionViewController.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 09.07.2024.
//

import UIKit

class AddTransactionViewController: VCStackViewController {
    
    private lazy var amountTextField: NumpadTextField = {
        let textField = NumpadTextField()
        
        textField.placeholder = L10n.Main.amount
        
        let tfAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "",
                                                             attributes: tfAttributes)
        
        return textField
    }()
    
    private lazy var categoriesRoundView = RoundView(titleLabel: L10n.AddTransaction.chooseCategory, height: 65, viewBackgroundColor: .darkBlue, viewTintColor: .white)
    
    private lazy var chevronView = ChevronView()
    
    private let categoryTableView = UITableView()
    
    private var isCategoryViewExpanded: Bool = false
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkBlue
        button.setTitle(L10n.Main.add, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        
        return button
    }()
    
    private var viewModel = AddTransactionViewModel()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViews()
    }
    
    //MARK: - Setup view
    
    override func addContent() {
        super.addContent()
        
        stackView.addArrangedSubview(amountTextField)
        stackView.addArrangedSubview(categoriesRoundView, withSpacing: 30)
        categoriesRoundView.addSubview(chevronView)
        stackView.addArrangedSubview(categoryTableView, withSpacing: 1)
        stackView.addArrangedSubview(addButton, withSpacing: 100)
    }
    
    override func configureContent() {
        super.configureContent()
        view.backgroundColor = .backgroundGray
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        categoryTableView.separatorStyle = .none
        categoryTableView.layer.cornerRadius = 10
        
        categoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            
        ])
        
    }
    //MARK: - Activities
    
    @objc private func showTeamsAction() {
        isCategoryViewExpanded.toggle()
        
        let tableViewHeight = isCategoryViewExpanded ? CGFloat(44 * TransactionCategory.allCases.count) : 0
                
        UIView.animate(withDuration: 0.3) {
            self.chevronView.chevronViewTapped()

            NSLayoutConstraint.deactivate(self.categoryTableView.constraints)
            self.categoryTableView.heightAnchor.constraint(equalToConstant: tableViewHeight).isActive = true
            
            self.view.layoutIfNeeded()
        }
    }
}

extension AddTransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TransactionCategory.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath)
        let category = viewModel.transactionCategories[indexPath.row]
        cell.textLabel?.text = category.title
        cell.imageView?.image = UIImage(systemName: category.image)
        
        return cell
    }
}
