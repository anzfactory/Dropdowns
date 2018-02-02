import UIKit

open class TitleView: UIView {

  open var dropdown: DropdownController!
  open var button: ArrowButton!
  open var action: ((Int) -> Void)?
    
  override open var intrinsicContentSize: CGSize {
    return UILayoutFittingExpandedSize
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
    button.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
    button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
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
    if let superView = self.superview {
        self.frame = CGRect(x: 0, y: 0, width: superView.frame.width, height: superView.frame.height)
    }
  }

  // MARK: - Action

  @objc func buttonTouched(_ button: ArrowButton) {
    dropdown.toggle()
  }
}
