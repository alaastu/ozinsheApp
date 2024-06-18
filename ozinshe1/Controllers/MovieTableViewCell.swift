//
//  MovieTableViewCell.swift
//  ozinshe1
//
//  Created by Туйаара Алаас on 09.03.2023.
//

import UIKit
import SDWebImage
class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var playView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        posterImageView.layer.cornerRadius = 8
        playView.layer.cornerRadius = 8
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setData(movie: Movie) {
//        posterImageView.image = UIImage(named: movie.poster_link)
        posterImageView.sd_setImage(with: URL(string: movie.poster_link))
        nameLabel.text = "Суперкелук Самурык"
        yearLabel.text = "• 2020 • Телехикая • Мультфильм"
    }
    }

