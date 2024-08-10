//
//  CategoriesCollectionViewCell.swift
//  Comp
//
// Created by Kaan Uzun on 4.05.2024.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoriesCollectionViewCell"
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
//        label.textAlignment = .center
        return label
    }()
    
    private let colors: [UIColor] = [
        .systemPink,
        .systemPurple,
        .systemBlue,
        .systemRed,
        .systemTeal,
        .systemYellow,
        .systemGreen,
        .systemOrange,
        .darkGray,
        .systemMint,
        .systemIndigo
    ]
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        label.snp.makeConstraints { make in
            make.left.right.equalTo(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
    func configure(with viewModel: CategoriesCollectionViewCellViewModel) {
        label.text = viewModel.title
        imageView.sd_setImage(with: viewModel.imageURL, completed: nil)
        contentView.backgroundColor = colors.randomElement()
    }
}
