//
//  RefreshTokenStorage.swift
//  Workplaces
//
//  Created by YesVladess on 09.06.2021.
//

import Foundation
import LocalAuthentication

protocol KeychainStorageProtocol: AnyObject {
    var pinCode: Atomic<String>? { get set }
    func set(pinCode value: String?)
    
    func saveRefreshTokenToKeychain(withRefreshToken refreshToken: String, andPin pinCode: String)
    func savePinToKeychainWithBiometry(pin pinCode: String)
    func getRefreshTokenFromKeychain(withPin pin: String) -> String?
    func getPinCodeFromKeychain() -> String?
    func checkIfPinIsSetInKeychain() -> Bool
    func checkIfRefreshTokenIsSetInKeychain() -> Bool
    func checkIfPinCodeIsSetInKeychain() -> Bool
    func clearKeychain()
}

final class KeychainStorage: KeychainStorageProtocol {

    // MARK: - Private Properties

    private let refreshTokenEntryName = "com.workplaces.refreshToken"
    private let pinCodeEntryName = "com.workplaces.pinCode"

    // MARK: - Public Properties

    var pinCode: Atomic<String>?

    // MARK: - Public Methods

    func set(pinCode value: String?) {
        if let pinCodeValue = value {
            pinCode = Atomic(wrappedValue: "")
            pinCode!.mutate { value in value = pinCodeValue }
        } else {
            pinCode = nil
        }
    }

    func saveRefreshTokenToKeychain(withRefreshToken refreshToken: String, andPin pinCode: String) {
        guard let refreshTokenData = refreshToken.data(using: .utf8) else { return }
        _ = KeychainHelper.createEntry(
            key: refreshTokenEntryName,
            data: refreshTokenData,
            password: pinCode
        )
    }

    func savePinToKeychainWithBiometry(pin pinCode: String) {
        guard let pinData = pinCode.data(using: .utf8) else { return }
        _ = KeychainHelper.createBioProtectedEntry(
            key: pinCodeEntryName,
            data: pinData
        )
    }

    func getRefreshTokenFromKeychain(withPin pin: String) -> String? {
        let context = LAContext()
        let pinData = pin.data(using: .utf8)
        context.setCredential(pinData, type: .applicationPassword)
        if let refreshTokenData = KeychainHelper.loadPassProtected(
            key: refreshTokenEntryName,
            context: context
        ) {
            return String(data: refreshTokenData, encoding: .utf8)
        } else { return nil }
    }

    func getPinCodeFromKeychain() -> String? {
        if let pinCodeData = KeychainHelper.loadBioProtected(key: pinCodeEntryName) {
            return String(data: pinCodeData, encoding: .utf8)
        } else { return nil }
    }

    func checkIfPinIsSetInKeychain() -> Bool {
        return KeychainHelper.available(key: pinCodeEntryName)
    }

    func checkIfRefreshTokenIsSetInKeychain() -> Bool {
        return KeychainHelper.available(key: refreshTokenEntryName)
    }

    func checkIfPinCodeIsSetInKeychain() -> Bool {
        return KeychainHelper.available(key: pinCodeEntryName)
    }

    func clearKeychain() {
        KeychainHelper.remove(key: refreshTokenEntryName)
        KeychainHelper.remove(key: pinCodeEntryName)
    }

}
