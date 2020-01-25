//
//  ETHService.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import Web3

class ETHService: ETHServiceProtocol {
    
    func isValidPrivateKey(key: String) -> EthereumPrivateKey? {
        let ethPrivateKey = try? EthereumPrivateKey(hexPrivateKey: key)
        return ethPrivateKey
    }
    
    func getAddress(fromPrivateKey key: String) -> String? {
        let ethPrivateKey = try? EthereumPrivateKey(hexPrivateKey: key)
        
        return ethPrivateKey?.address.hex(eip55: true)
    }
    
    func getBalance(fromAddress: String) -> String {
        return ""
    }
}

protocol ETHServiceProtocol {
    func getAddress(fromPrivateKey key: String) -> String?
    
    func isValidPrivateKey(key: String) -> EthereumPrivateKey?
    
    func getBalance(fromAddress: String) -> String
}
