//
//  DataAssembly.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation

struct DataAssembly {
    //MARK: - HomeProvider
    static func homeProvider() -> HomeProviderProtocol {
        let provider = HomeProvider()
        provider.manager = NativeManager()
        return provider
    }
}
