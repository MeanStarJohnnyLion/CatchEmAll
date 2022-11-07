//
//  CreatureDetailViewModel.swift
//  CatchEmAll
//
//  Created by Johnny Lion on 10/29/22.
//

import Foundation


@MainActor
class CreatureDetailViewModel: ObservableObject {
    
    
    private struct Returned: Codable {
        var height: Double?
        var weight: Double?
        var sprites: Sprite
    }
    
    struct Sprite: Codable {
        var front_default: String?
        var other: Other
    }
    
    struct Other: Codable {
        var officialArtwork: OfficialArtwork
        
        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }
    
    struct OfficialArtwork: Codable {
        var front_default: String?
    }
    
    
    var urlString = ""
    @Published var height = 0.0
    @Published var weight = 0.0
    @Published var imageURL = ""

    
    
    func getData() async {
        print("🕸 We are accesing the url \(urlString)")
        
        
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("😡 JSON ERROR: Could not decode returned JSON data")
                return
            }
            self.height = returned.height ?? 0.0
            self.weight = returned.weight ?? 0.0
            self.imageURL = returned.sprites.other.officialArtwork.front_default ?? "n/a"
        } catch {
            print("😡 ERROR: Could not use URl at \(urlString) to get data and response")
        }
    }
}
