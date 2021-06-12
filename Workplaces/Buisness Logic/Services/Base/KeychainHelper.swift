//
//  KeychainHelper.swift
//  Workplaces
//
//  Created by YesVladess on 09.06.2021.
//

import Foundation
import LocalAuthentication

class KeychainHelper {

    // MARK: - SecAccessControl

    static func getPwSecAccessControl() -> SecAccessControl? {
        var access: SecAccessControl?
        var error: Unmanaged<CFError>?

        access = SecAccessControlCreateWithFlags(
            kCFAllocatorDefault,
            kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
            .applicationPassword,
            &error)
        return access
    }

    static func getBioSecAccessControl() -> SecAccessControl? {
        var access: SecAccessControl?
        var error: Unmanaged<CFError>?

        if #available(iOS 11.3, *) {
            access = SecAccessControlCreateWithFlags(nil,
                                                     kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                                                     .biometryCurrentSet,
                                                     &error)
        } else {
            access = SecAccessControlCreateWithFlags(nil,
                                                     kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                                                     .touchIDCurrentSet,
                                                     &error)
        }
        return access
    }

    // MARK: - Save to Keychain

    static func createEntry(key: String, data: Data, password: String) -> OSStatus {
        remove(key: key)

        let context = LAContext()
        context.setCredential(Data(password.utf8), type: .applicationPassword)
        guard let accessControl = getPwSecAccessControl() else { return errSecAuthFailed }

        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key,
            kSecAttrAccessControl as String: accessControl,
            kSecValueData as String: data as NSData,
            kSecUseAuthenticationContext: context] as CFDictionary

        return SecItemAdd(query, nil)
    }

    static func createBioProtectedEntry(key: String, data: Data) -> OSStatus {
        remove(key: key)
        guard let accessControl = getBioSecAccessControl() else { return errSecAuthFailed }

        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key,
            kSecAttrAccessControl as String: accessControl,
            kSecValueData as String: data ] as CFDictionary

        return SecItemAdd(query as CFDictionary, nil)
    }

    // MARK: - Remove from Keychain

    static func remove(key: String) {
        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key]

        SecItemDelete(query as CFDictionary)
    }

    // MARK: - Get From Keychian

    static func loadPassProtected(key: String, context: LAContext? = nil) -> Data? {
        guard let accessControl = getPwSecAccessControl() else { return nil }

        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue as CFBoolean,
            kSecAttrAccessControl as String: accessControl,
            kSecMatchLimit as String: kSecMatchLimitOne]

        if let context = context {
            query[kSecUseAuthenticationContext as String] = context
            query[kSecUseAuthenticationUI as String] = kSecUseAuthenticationUIFail
        }

        var dataTypeRef: AnyObject?

        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            if let data = dataTypeRef as? Data {
                return data
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

    static func loadBioProtected(key: String,
                                 context: LAContext? = nil,
                                 prompt: String? = nil
    ) -> Data? {
        guard let accessControl = getBioSecAccessControl() else { return nil }

        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue as CFBoolean,
            kSecAttrAccessControl as String: accessControl,
            kSecMatchLimit as String: kSecMatchLimitOne ]

        if let context = context {
            query[kSecUseAuthenticationContext as String] = context
            query[kSecUseAuthenticationUI as String] = kSecUseAuthenticationUISkip
        }

        if let prompt = prompt {
            query[kSecUseOperationPrompt as String] = prompt
        }

        var dataTypeRef: AnyObject?

        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            if let data = dataTypeRef as? Data {
                return data
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

    static func available(key: String) -> Bool {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue as CFBoolean,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecUseAuthenticationUI as String: kSecUseAuthenticationUIFail] as CFDictionary

        var dataTypeRef: AnyObject?

        let status = SecItemCopyMatching(query, &dataTypeRef)

        // errSecInteractionNotAllowed - for a protected item
        // errSecAuthFailed - when touch Id is locked
        return status == noErr || status == errSecInteractionNotAllowed || status == errSecAuthFailed
    }

}
