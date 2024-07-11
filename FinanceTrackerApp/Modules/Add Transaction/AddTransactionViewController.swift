//
//  AddTransactionViewController.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 09.07.2024.
//

import UIKit

protocol AddTransactionDelegate: AnyObject {
    func addTransaction(transaction: TransactionModel)
}

class AddTransactionViewController: UIViewController {
    
    weak var delegate: AddTransactionDelegate?
    
    private lazy var amountTextField: NumpadTextField = {
        let textField = NumpadTextField()
        
        textField.placeholder = L10n.Main.amount
        
        let tfAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "",
                                                             attributes: tfAttributes)
        
        return textField
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkBlue
        button.setTitle(L10n.Main.add, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        
        button.addTarget(self, action: #selector(addTransactionTapped), for: .touchUpInside)
        
        return button
    }()
    
    private var viewModel = AddTransactionViewModel()
    
    //MARK: - Category view
    
    private let categoryLabel = SGExpandableChevronView(titleLabel: "", infoLabel: L10n.AddTransaction.chooseCategory)
    
    private lazy var categoriesRoundView = RoundView(height: 65)
        
    private let categoryTableView: UITableView = {
         let tableView = UITableView()
         tableView.translatesAutoresizingMaskIntoConstraints = false
        
         return tableView
     }()
    
    private var isCategoryViewExpanded: Bool = false
    
//    private lazy var categoryStackView = setupStackView(views: [categoriesRoundView, categoryTableView], axis: .vertical)
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViews()
    }
    
    //MARK: - Setup view
    
    private func loadViews() {
        addContents()
        configureContents()
        makeConstraintss()
        
    }
    
    private func addContents() {
        view.addSubview(amountTextField)
        
        categoriesRoundView.addSubview(categoryLabel)
        view.addSubview(categoryTableView)
        view.addSubview(categoriesRoundView)

        view.addSubview(addButton)
        
        
        view.backgroundColor = .backgroundGray
    }
    
    private func configureContents() {
        navigationItem.backButtonTitle = "Back"
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        categoryTableView.separatorStyle = .none
        categoryTableView.layer.cornerRadius = 10
        
        categoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        
        let categoryGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(showCategoriesAction))
        categoriesRoundView.addGestureRecognizer(categoryGestureRecogniser)
    }
    
    private func makeConstraintss() {
        NSLayoutConstraint.activate([
            amountTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            amountTextField.heightAnchor.constraint(equalToConstant: 52),
            
            categoriesRoundView.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 35),
            categoriesRoundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            categoriesRoundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            categoryLabel.trailingAnchor.constraint(equalTo: categoriesRoundView.trailingAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: categoriesRoundView.leadingAnchor),
            
            categoryTableView.topAnchor.constraint(equalTo: categoriesRoundView.bottomAnchor, constant: 0.3),
            categoryTableView.leadingAnchor.constraint(equalTo: categoriesRoundView.leadingAnchor),
            categoryTableView.trailingAnchor.constraint(equalTo: categoriesRoundView.trailingAnchor),
            
            addButton.topAnchor.constraint(equalTo: categoryTableView.bottomAnchor, constant: 35),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            addButton.heightAnchor.constraint(equalToConstant: 52)
            
        ])
    }
    
    //MARK: - Activities
    
    @objc private func showCategoriesAction() {
        isCategoryViewExpanded.toggle()
        
        let tableViewHeight = isCategoryViewExpanded ? viewModel.tableViewHeight : 0
        categoryTableView.isHidden = false
                
        UIView.animate(withDuration: 0.3) {
            self.categoryLabel.chevronViewTapped()

            NSLayoutConstraint.deactivate(self.categoryTableView.constraints)
            self.categoryTableView.heightAnchor.constraint(equalToConstant: tableViewHeight).isActive = true
            
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func addTransactionTapped() {
        
        print("Before check")
        
        guard let amountText = amountTextField.text else { return }
        
        if let amount = Double(amountText.replaceWithDot()) {
            
            let transaction = TransactionModel(
                id: UUID().uuidString,
                transactionType: .spend,
                timestamp: Date(),
                amount: amount,
                category: viewModel.chosenCategory
            )

            delegate?.addTransaction(transaction: transaction)
            dismiss(animated: true, completion: nil)
            
            print("Here")
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension AddTransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.transactionCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath)
        let category = viewModel.transactionCategories[indexPath.row]
        
        cell.textLabel?.text = category.title
        cell.imageView?.image = UIImage(systemName: category.image)
        cell.tintColor = .black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.chosenCategory = viewModel.transactionCategories[indexPath.row]
        categoryLabel.infoLabel.text = viewModel.chosenCategory?.title
        
        isCategoryViewExpanded = false
        
        UIView.animate(withDuration: 0.3) {
            NSLayoutConstraint.deactivate(self.categoryTableView.constraints)
            self.categoryLabel.chevronViewTapped()
            self.view.layoutIfNeeded()
        }
    }
}
