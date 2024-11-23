//
//  Recipe.swift
//  DailyCook
//
//  Created by 이영호 on 11/23/24.
//

import Foundation

// API 전체 응답 구조
struct RecipeRespose: Codable {
    let COOKRCP01: RecipeResult
}

// API 결과 구조
struct RecipeResult: Codable {
    let total_count: String
    let row: [Recipe]?
    let RESULT: APIResult
}

// API 결과 상태
struct APIResult: Codable {
    let MSG: String
    let CODE: String
}

// 레시피 모델
struct Recipe: Codable, Identifiable {
    // API에서는 id가 없으므로 RCP_SEQ를 id로 사용
    var id: String { RCP_SEQ }
    
    let RCP_SEQ: String          // 레시피 일련번호
    let RCP_NM: String          // 레시피 이름
    let RCP_WAY2: String        // 조리방법
    let RCP_PAT2: String        // 요리종류
    let INFO_WGT: String        // 중량(1인분)
    let INFO_ENG: String        // 열량
    let INFO_CAR: String        // 탄수화물
    let INFO_PRO: String        // 단백질
    let INFO_FAT: String        // 지방
    let INFO_NA: String         // 나트륨
    let HASH_TAG: String        // 해시태그
    let ATT_FILE_NO_MAIN: String // 메인 이미지 URL
    let ATT_FILE_NO_MK: String   // 만드는 과정 이미지 URL
    let RCP_PARTS_DTLS: String   // 재료 정보
    let MANUAL01: String?        // 만드는 방법 Step 1
    let MANUAL_IMG01: String?    // 만드는 방법 Step 1 이미지
    let MANUAL02: String?        // 만드는 방법 Step 2
    let MANUAL_IMG02: String?    // 만드는 방법 Step 2 이미지
    let MANUAL03: String?        // 만드는 방법 Step 3
    let MANUAL_IMG03: String?    // 만드는 방법 Step 3 이미지
    let MANUAL04: String?        // 만드는 방법 Step 4
    let MANUAL_IMG04: String?    // 만드는 방법 Step 4 이미지
    let MANUAL05: String?        // 만드는 방법 Step 5
    let MANUAL_IMG05: String?    // 만드는 방법 Step 5 이미지
    let MANUAL06: String?        // 만드는 방법 Step 6
    let MANUAL_IMG06: String?    // 만드는 방법 Step 6 이미지
    let MANUAL07: String?        // 만드는 방법 Step 7
    let MANUAL_IMG07: String?    // 만드는 방법 Step 7 이미지
    let MANUAL08: String?        // 만드는 방법 Step 8
    let MANUAL_IMG08: String?    // 만드는 방법 Step 8 이미지
    let MANUAL09: String?        // 만드는 방법 Step 9
    let MANUAL_IMG09: String?    // 만드는 방법 Step 9 이미지
    let MANUAL10: String?        // 만드는 방법 Step 10
    let MANUAL_IMG10: String?    // 만드는 방법 Step 10 이미지
    let MANUAL11: String?        // 만드는 방법 Step 11
    let MANUAL_IMG11: String?    // 만드는 방법 Step 11 이미지
    let MANUAL12: String?        // 만드는 방법 Step 12
    let MANUAL_IMG12: String?    // 만드는 방법 Step 12 이미지
    let MANUAL13: String?        // 만드는 방법 Step 13
    let MANUAL_IMG13: String?    // 만드는 방법 Step 13 이미지
    let MANUAL14: String?        // 만드는 방법 Step 14
    let MANUAL_IMG14: String?    // 만드는 방법 Step 14 이미지
    let MANUAL15: String?        // 만드는 방법 Step 15
    let MANUAL_IMG15: String?    // 만드는 방법 Step 15 이미지
    let MANUAL16: String?        // 만드는 방법 Step 16
    let MANUAL_IMG16: String?    // 만드는 방법 Step 16 이미지
    let MANUAL17: String?        // 만드는 방법 Step 17
    let MANUAL_IMG17: String?    // 만드는 방법 Step 17 이미지
    let MANUAL18: String?        // 만드는 방법 Step 18
    let MANUAL_IMG18: String?    // 만드는 방법 Step 18 이미지
    let MANUAL19: String?        // 만드는 방법 Step 19
    let MANUAL_IMG19: String?    // 만드는 방법 Step 19 이미지
    let MANUAL20: String?        // 만드는 방법 Step 20
    let MANUAL_IMG20: String?    // 만드는 방법 Step 20 이미지
    
    // 조리 과정 단계를 배열로 반환하는 계산 속성
    var cookingSteps: [(description: String, imageURL: String)] {
        var steps: [(String, String)] = []
        
        // 반복문으로 nil이 아닌 step들을 배열에 추가
        let mirror = Mirror(reflecting: self)
        for i in 1...20 {
            let stepKey = String(format: "MANUAL%02d", i)
            let imageKey = String(format: "MANUAL_IMG%02d", i)
            
            if let stepValue = mirror.children.first(where: { $0.label == stepKey })?.value as? String,
               let imageValue = mirror.children.first(where: { $0.label == imageKey })?.value as? String,
               !stepValue.isEmpty {
                steps.append((stepValue, imageValue))
            }
        }
        
        return steps
    }
}
