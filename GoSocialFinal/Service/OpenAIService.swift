//
//  OpenAIService.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/28/23.
//

import Foundation
import Alamofire
import Combine

class OpenAIService {
    let baseURL = "https://api.openai.com/v1/"
    
    func sendMessage(message: String) -> AnyPublisher<OpenAICompletionsResponse, Error> {
        let body = OpenAICompletionsBody(model: "text-davinci-003", prompt: message, temperature: 0.7)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.openAIAPIKey)"
        ]
        
        return Future { [weak self] promise in
            
            guard let self = self else {return}
            
            AF.request(self.baseURL + "completions", method: .post, parameters: body, encoder: .json, headers: headers).responseDecodable(of: OpenAICompletionsResponse.self) { response in
                switch response.result {
                case .success(let result):
                    promise(.success(result))
                    
                case .failure(let error):
                    promise(.failure(error))
                }
                
            }
            
        }
        .eraseToAnyPublisher()
    }
}

struct OpenAICompletionsBody: Encodable {
    let model: String
    let prompt: String
    let temperature: Float?
}

//struct OpenAICompletionsResponse: Decodable {
//    let id: String
//    let choices: [OpenAICompletionsChoice]
//}

struct OpenAICompletionsResponse: Decodable {
    let id: String
    let choices: [OpenAICompletionsChoice]

    private enum CodingKeys: String, CodingKey {
        case id
        case choices
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        choices = try container.decode([OpenAICompletionsChoice].self, forKey: .choices)
    }
}


//struct OpenAICompletionsChoice {
//    let text: String
//}

struct OpenAICompletionsChoice: Decodable {
    let text: String

    private enum CodingKeys: String, CodingKey {
        case text
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: .text)
    }
}
