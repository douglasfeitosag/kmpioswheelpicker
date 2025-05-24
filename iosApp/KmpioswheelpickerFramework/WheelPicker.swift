import UIKit

@objc(CustomWheelPickerDelegate)
public protocol CustomWheelPickerDelegate: AnyObject {
    func didSelectWithIndex(_ index: Int)
}

@objc(PickerView)
public final class WheelPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    @objc public weak var pickerCallback: CustomWheelPickerDelegate?

    private var options: [String] = []
    private var selectedIndex: Int = 0

    @objc public init(options: NSArray, selectedIndex: Int) {
       super.init(frame: .zero)

       self.options = options.compactMap { $0 as? String }
       self.selectedIndex = selectedIndex
       self.delegate = self
       self.dataSource = self
       self.selectRow(selectedIndex, inComponent: 0, animated: false)
       self.translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    public override func didMoveToSuperview() {
       super.didMoveToSuperview()
       config()
    }

    private func config() {
       guard let superview = self.superview else { return }
       NSLayoutConstraint.activate([
           self.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
           self.topAnchor.constraint(equalTo: superview.topAnchor),
           self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
           self.heightAnchor.constraint(equalToConstant: 216),
           self.widthAnchor.constraint(equalToConstant: 320)
       ])
       pickerCallback?.didSelectWithIndex(selectedIndex)
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    public func pickerView(_ pickerView: UIPickerView,
                           numberOfRowsInComponent component: Int) -> Int {
        options.count
    }

    public func pickerView(_ pickerView: UIPickerView,
                           titleForRow row: Int,
                           forComponent component: Int) -> String? {
        options[row]
    }

    public func pickerView(_ pickerView: UIPickerView,
                           didSelectRow row: Int,
                           inComponent component: Int) {
        pickerCallback?.didSelectWithIndex(row)
    }
}



