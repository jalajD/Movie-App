//
//  TitleCollectionViewCell.swift
//  Movie-App
//
//  Created by Deotwal, Jalaj | Ronnie on 2025/12/11.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    static let identifier = "TitleCollectionViewCell"

    private let posterImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        imageview.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        return imageview
    }()

    private let shimmerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        contentView.addSubview(shimmerView)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
        shimmerView.frame = contentView.bounds
    }

    public func configure(with model: String) {
        shimmerView.isHidden = false
        shimmerView.startShimmer()
        posterImageView.image = nil

        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
            shimmerView.stopShimmer()
            shimmerView.isHidden = true
            return
        }

        posterImageView.sd_setImage(with: url) { [weak self] _, error, _, _ in
            self?.shimmerView.stopShimmer()
            self?.shimmerView.isHidden = true
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        shimmerView.stopShimmer()
        shimmerView.isHidden = true
    }
}
