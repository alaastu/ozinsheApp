//
//  TableViewCell.swift
//  ozinshe1
//
//  Created by Туйаара Алаас on 24.04.2023.
//

import UIKit
import SDWebImage


class FavoriteTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(movie: String) {
//        posterImageView.sd_setImage(with: URL(string: movie.poster_link), completed: nil)
//
//        nameLabel.text = movie.name
//        yearLabel.text = "\(movie.year)"
        print(movie)
    }
}
