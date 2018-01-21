import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let dateComponents = calendar.components(in: NSTimeZone.default, from: NSDate() as Date)
        
        if let hourOfDay = dateComponents.hour, (hourOfDay > 19 || hourOfDay <= 6){
            view.backgroundColor = UIColor.darkGray
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.placeholder = NSLocalizedString("value", tableName: "Main", comment:"comment")
        
        print("ConversionViewController loaded its view")
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSDecimalNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //let allowedCharacterSet = NSCharacterSet(charactersIn: "0123456789., ")
        
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        if string.isEmpty { return true }
       
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementStringHasDecimalSeparator = string.range(of: decimalSeparator)
        let allowedCharactersSet = NSCharacterSet(charactersIn: decimalSeparator + "0123456789")
        let allowedCharacters = string.rangeOfCharacter(from: allowedCharactersSet as CharacterSet)
        
        if existingTextHasDecimalSeparator != nil
            && replacementStringHasDecimalSeparator != nil
            || allowedCharacters == nil{
                return false
        }

        return true
    }
    
}

