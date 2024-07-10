// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  public enum AddTransaction {
    /// Choose category
    public static let chooseCategory = L10n.tr("Localizable", "addTransaction.chooseCategory", fallback: "Choose category")
  }
  public enum Main {
    /// Add
    public static let add = L10n.tr("Localizable", "main.add", fallback: "Add")
    /// Add transaction
    public static let addTransaction = L10n.tr("Localizable", "main.addTransaction", fallback: "Add transaction")
    /// Amount
    public static let amount = L10n.tr("Localizable", "main.amount", fallback: "Amount")
    /// Enter Deposit Amount
    public static let enterDepositAmount = L10n.tr("Localizable", "main.enterDepositAmount", fallback: "Enter Deposit Amount")
    /// Localizable.strings
    ///   FinanceTrackerApp
    /// 
    ///   Created by Vova Novosad on 09.07.2024.
    public static let recieve = L10n.tr("Localizable", "main.recieve", fallback: "Recieve BTC")
    /// Submit
    public static let submit = L10n.tr("Localizable", "main.submit", fallback: "Submit")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = Bundle.main.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
