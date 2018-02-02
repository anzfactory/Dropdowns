import UIKit

open class ArrowButton: UIButton {

  public init() {
    super.init(frame: CGRect.zero)
    self.imageView?.contentMode = .scaleAspectFit
    let imageSize = Config.ArrowButton.Text.font.pointSize * 0.8
    let arrowImage = AssetManager.image("dropdown_arrow")?.resize(size: CGSize(width: imageSize, height: imageSize))?.withRenderingMode(.alwaysTemplate)
    self.setImage(arrowImage, for: .normal)
    self.setImage(arrowImage, for: .highlighted)
    
    self.setTitleColor(Config.ArrowButton.Text.color, for: .normal)
    self.titleLabel?.font = Config.ArrowButton.Text.font
    
    self.tintColor = Config.ArrowButton.Text.color
    self.setTitleColor(Config.ArrowButton.Text.selectedColor, for: .highlighted)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    
    guard let image = self.imageView?.image else {
        return
    }
    let padding: CGFloat = 4.0
    self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.frame.width - image.size.width + padding, bottom: 0, right: -(self.frame.width - image.size.width + padding))
    self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -image.size.width, bottom: 0, right: image.size.width)
  }

  // MARK: - Touch

  open override var isHighlighted: Bool {
    didSet {
        if self.isHighlighted {
            self.tintColor = Config.ArrowButton.Text.selectedColor
        } else {
            self.tintColor = Config.ArrowButton.Text.color
        }
    }
  }
}

extension UIImage {
  func resize(size _size: CGSize) -> UIImage? {
    let widthRatio = _size.width / size.width
    let heightRatio = _size.height / size.height
    let ratio = widthRatio < heightRatio ? widthRatio : heightRatio
    
    let resizedSize = CGSize(width: size.width * ratio, height: size.height * ratio)
    
    UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0)
    draw(in: CGRect(origin: .zero, size: resizedSize))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return resizedImage
  }
}
