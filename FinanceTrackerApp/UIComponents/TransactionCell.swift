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
        label.textColor = .black
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        loadViews()
        addContent()
        makeConstrains()
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
                
        if let category = transaction.category {
            categoryImageView.image = UIImage(systemName: category.image)
        }
        
        btcAmountLabel.text = "\(transaction.amount) BTC"
        dateLabel.text = DateFormatter.MMddyy.string(from: transaction.timestamp)
        
        transactionImageView.image = UIImage(systemName: transaction.transactionType.image)
    }
    
    func makeConstrains() {
        NSLayoutConstraint.activate([
            categoryImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            categoryImageView.heightAnchor.constraint(equalToConstant: 25),
            categoryImageView.widthAnchor.constraint(equalToConstant: 25),
            categoryImageView.centerYAnchor.constraint(equalTo: centerYAnchor),

            
            btcAmountLabel.leadingAnchor.constraint(equalTo: categoryImageView.trailingAnchor, constant: 20),
            btcAmountLabel.trailingAnchor.constraint(equalTo: transactionImageView.leadingAnchor, constant: -15),
            btcAmountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
//            btcAmountLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -15),
            
            dateLabel.leadingAnchor.constraint(equalTo: btcAmountLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: btcAmountLabel.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: btcAmountLabel.bottomAnchor, constant: 5),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            
            contentView.heightAnchor.constraint(equalToConstant: 75),
            
            transactionImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            transactionImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            transactionImageView.heightAnchor.constraint(equalToConstant: 17),
            transactionImageView.widthAnchor.constraint(equalToConstant: 17)
        ])
    }
}
