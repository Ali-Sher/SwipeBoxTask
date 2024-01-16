//
//  NetworkManager.swift
//  SwipeBoxTask
//
//  Created by Ali Sher on 14/01/2024.
//

import Foundation
import Reachability

class NetworkManager {

    static let shared = NetworkManager()
    private var reachability: Reachability?

    private init() {
        // Initialize Reachability
        reachability = try? Reachability()

        // Register for the network reachability notification
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: .reachabilityChanged, object: reachability)

        do {
            // Start monitoring the network reachability
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    @objc private func reachabilityChanged(notification: Notification) {
        updateNetworkStatus()
    }

    private func updateNetworkStatus() {
        guard let currentReachability = reachability else { return }

        if currentReachability.connection == .unavailable {
            print("Device is not connected to the internet")
        } else {
            print("Device is connected to the internet")
        }
    }

    deinit {
        // Stop monitoring the network reachability when the singleton is deallocated
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }

    // Public method to check the current network status
    func isDeviceConnected() -> Bool {
        guard let currentReachability = reachability else { return false }
        return currentReachability.connection != .unavailable
    }
}
