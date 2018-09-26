import UIKit

open class TitleView: UIView {

  open var dropdown: DropdownController!
  open var button: ArrowButton!
  open var action: ((Int) -> Void)?
    
  override open var intrinsicContentSize: CGSize {
    return UIView.layoutFittingExpandedSize
  }

  // MARK: - Initialization

  public init?(navigationController: UINavigationController, title: String, items: [String], initialIndex: Int = 0) {
    super.init(frame: .zero)

    // Button
    button = ArrowButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(title, for: .normal)
    button.addTarget(self, action: #selector(buttonTouched(_:)), for: .touchUpInside)
    addSubview(button)
    button.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
    button.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
    
    // Content
    let contentController = TableController(items: items, initialIndex: initialIndex)

    // Dropdown
    guard let dropdown = DropdownController(contentController: contentController, navigationController: navigationController)
      else { return nil }

    self.dropdown = dropdown

    contentController.action = { [weak self, weak dropdown] index in
      self?.button.setTitle(items[index], for: .normal)
      self?.action?(index)
      self?.setNeedsLayout()
      dropdown?.hide()
    }

    contentController.dismiss = { [weak dropdown] in
      dropdown?.hide()
    }

    dropdown.animationBlock = { [weak self] showing in
      self?.button.imageView?.transform = showing
        ? CGAffineTransform(rotationAngle: CGFloat.pi) : CGAffineTransform.identity
    }
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open override func layoutSubviews() {
    super.layoutSubviews()
    
    if #available(iOS 11.0, *) {
    } else {
      if let superview = self.superview {
        var frame = self.frame
        frame.origin.x = (superview.frame.size.width - self.button.frame.width) * 0.5
        frame.origin.y = (superview.frame.size.height - self.button.frame.height) * 0.5
        frame.size = self.button.frame.size
        self.frame = frame
      }
    }
    
  }

  // MARK: - Action

  @objc func buttonTouched(_ button: ArrowButton) {
    dropdown.toggle()
  }
}
