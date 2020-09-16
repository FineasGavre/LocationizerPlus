//
//  LocationFetcher.swift
//  LocationizerPlus
//
//  Created by Fineas Gavre on 16.09.2020.
//

import Foundation
import Combine

fileprivate struct LocationResponse: Decodable {
    let status: String
    let locations: [Location]
}

class LocationFetcher {
    
    // MARK: - Public Methods
    
    func fetchLocationsFromServer() -> AnyPublisher<[Location], Never>  {
        guard let url = URL(string: API.backendURL + API.Path.getLocations) else { return Just([]).eraseToAnyPublisher()  }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (arg0) -> [Location] in
                let (data, _) = arg0
                let dataResponse = try JSONDecoder().decode(LocationResponse.self, from: data)
                return dataResponse.locations
            }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
