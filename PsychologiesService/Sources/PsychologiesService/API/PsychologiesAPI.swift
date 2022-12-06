//
//  PsychologiesAPI.swift
//  
//
//  Created by Michael Bernat on 03.12.2022.
//

import API

enum PsychologiesAPI: API {
    
    case getTraitQuiz
    case submitAnswers(traitQuizId: String, answerIds: [String])
    
    var baseUrlText: String { "https://api.psychologies.teamway" }
    
    var path: String {
        switch self {
        case .getTraitQuiz: return "traitQuiz"
        case .submitAnswers: return "traitQuiz"
        }
    }
    
    var method: APIMethod {
        switch self {
        case .getTraitQuiz: return .get
        case .submitAnswers: return .post
        }
    }
    
    var headers: [String : String]? { nil }
    
    var jsonParameters: [String : Any]? {
        switch self {
        case .getTraitQuiz:
            return nil
        case .submitAnswers(let traitQuizId, let answerIds):
            return [
                "traitQuizId" : traitQuizId,
                "answerIds" : answerIds
            ]
        }
    }
}
