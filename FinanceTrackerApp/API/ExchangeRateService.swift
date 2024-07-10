//
//  ExchangeRateService.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 11.07.2024.
//

import Foundation

class ExchangeRateService {
    static let shared = ExchangeRateService()
    
    private let cacheDuration: TimeInterval = 3600
    
    private init() {}
    
    func fetchExchangeRate(completion: @escaping (Double?) -> Void) {
        let now = Date()
        if let lastFetch = UserDefaults.standard.object(forKey: Constants.lastFetchKey) as? Date, now.timeIntervalSince(lastFetch) < cacheDuration {
            let cachedRate = UserDefaults.standard.double(forKey: Constants.rateKey)
            completion(cachedRate)
            return
        }
        
        guard let url = URL(string: Constants.apiUrl) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let bpi = json["bpi"] as? [String: Any],
                   let usd = bpi["USD"] as? [String: Any],
                   let rateString = usd["rate_float"] as? Double {
                    
                    UserDefaults.standard.set(rateString, forKey: Constants.rateKey)
                    UserDefaults.standard.set(now, forKey: Constants.lastFetchKey)
                    
                    completion(rateString)
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }
        
        task.resume()
    }
}
