import UIKit

class CarCell : UICollectionViewCell {
    
    var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    var numberPlate : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
        
    var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(numberPlate)
        autoLayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayoutSubviews(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        numberPlate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: imageView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor)
        ])
    }
    
    func bindViewData(_ vehicle: Vehicle){
        nameLabel.text = vehicle.vehicleMake
        numberPlate.text = vehicle.licensePlateNumber
        if let posterURL = URL(string: vehicle.vehiclePicAbsoluteURL) {
            ImageCache.shared.loadImage(fromURL: posterURL, forImageView: self.imageView)
        }
    }
}
