//
//  TransactionCell.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 09.07.2024.
//

import UIKit

class TransactionCell: UITableViewCell, VCInsides {
    
    //MARK: - Properties
    
    var transaction: TransactionModel? {
        didSet {
            configureCell()
        }
    }
    
    let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 22
        
        return imageView
    }()
    
    let transactionImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let btcAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .white
        
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        loadViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Setup view
    
    func addContent() {
        contentView.addSubview(transactionImageView)
        contentView.addSubview(btcAmountLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(categoryImageView)
    }
    
    private func configureCell() {
        
        guard let transaction = transaction else { return }
        
        backgroundColor = .lightGray
        
        if let category = transaction.category {
            categoryImageView.image = UIImage(systemName: category.image)
        }
        
        btcAmountLabel.text = "\(transaction.amount)"
        dateLabel.text = DateFormatter.MMddyy.string(from: transaction.timestamp)
        
        transactionImageView.image = UIImage(systemName: transaction.transactionType.image)
    }
    
    func makeConstrains() {
        let stackView = UIStackView(arrangedSubviews: [btcAmountLabel, dateLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        NSLayoutConstraint.activate([
            categoryImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            categoryImageView.heightAnchor.constraint(equalToConstant: 35),
            categoryImageView.widthAnchor.constraint(equalToConstant: 35),
            
            stackView.leadingAnchor.constraint(equalTo: categoryImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: transactionImageView.leadingAnchor, constant: -10),
            
            transactionImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
