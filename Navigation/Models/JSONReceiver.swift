//
//  JSONReceiver.swift
//  Navigation
//
//  Created by Maksim Kruglov on 27.11.2022.
//

import Foundation

struct Planet: Codable {
    let name, rotationPeriod, orbitalPeriod, diameter: String
    let climate, gravity, terrain, surfaceWater: String
    let population: String
    let residents, films: [String]
    let created, edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url
    }
}

struct TatooineResident: Codable {
    let name, height, mass, hairColor: String
    let skinColor, eyeColor, birthYear, gender: String
    let homeworld: String
    let films: [String]
    let species, vehicles, starships: [String]
    let created, edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender, homeworld, films, species, vehicles, starships, created, edited, url
    }
}

var titleForCase1: String = ""
var titleForCase2: String = ""
var residents: [String] = []

struct JSONReceiver {
    
    static func receiveJSON (forConfiguration: AppConfiguration){
        
        let URLSession = URLSession.shared
        
        if let url = URL(string: forConfiguration.rawValue) {
            let request = URLRequest(url: url)
            
            let dataTask = URLSession.dataTask(with: request, completionHandler: {data, responce, error in
                if let unwrapedData = data {
                    
                    switch forConfiguration {
                    case AppConfiguration.fourth:
                        do {
                            let serializedDictionary = try JSONSerialization.jsonObject(with: unwrapedData, options: [])
                            if let dictionary = serializedDictionary as? [String: Any] {
                                if let titleForLabel = dictionary["title"] as? String {
                                    titleForCase1 = titleForLabel
                                }
                            }
                        } catch {print(error)}
                        
                    case AppConfiguration.fifth:
                        do {
                            let awesomePlanet = try JSONDecoder().decode(Planet.self, from: unwrapedData)
                            titleForCase2 = awesomePlanet.orbitalPeriod
                            residents = awesomePlanet.residents
                            print(residents)
                        } catch {print(error)}
                        
                    default: print("Something Went Wrong!")
                    }
                }
            })
            
            dataTask.resume()
            
        }
    }
}
