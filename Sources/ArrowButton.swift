import UIKit

open class ArrowButton: UIButton {

  public init() {
    super.init(frame: CGRect.zero)
    self.imageView?.contentMode = .scaleAspectFit
    self.setImage(AssetManager.image("dropdown_arrow")?.withRenderingMode(.alwaysTemplate), for: .normal)
    self.setImage(AssetManager.image("dropdown_arrow")?.withRenderingMode(.alwaysTemplate), for: .highlighted)
    
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
    
    if self.imageView?.image == nil {
        return
    }
    
    let verticalPadding = (self.frame.height - Config.ArrowButton.Text.font.pointSize) * 0.5 * 1.1
    let adjustedImageSize = self.frame.height - (verticalPadding * 2)
    
    self.imageEdgeInsets = UIEdgeInsets(top: verticalPadding, left: self.frame.width - adjustedImageSize, bottom: verticalPadding, right: -(self.frame.width - adjustedImageSize))
    self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -adjustedImageSize, bottom: 0, right: adjustedImageSize)
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
