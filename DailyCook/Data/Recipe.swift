//
//  Recipe.swift
//  DailyCook
//
//  Created by 이영호 on 11/23/24.
//

struct RecipeRespose: Decodable {
    let data: RecipeData
    
    struct RecipeData: Decodable {
        let list: [Recipe]
    }
}

struct Recipe: Codable, Identifiable {
    var id: String { RCP_SEQ }
    let RCP_SEQ: String // 일련번호
    let RCP_NM: String // 메뉴명
    let RCP_WAY2: String // 조리방법
    let RCP_PAT2: String // 요리종류
    let INFO_WGT: String? // 중량(1인분)
    let INFO_ENG: String? // 열량
    let INFO_CAR: String? // 탄수화물
    let INFO_PRO: String? // 단백질
    let INFO_FAT: String? // 지방
    let INFO_NA: String? // 나트륨
    let HASH_TAG: String? // 해쉬태그
    let ATT_FILE_NO_MAIN: String? // 이미지 경로
//    let ATT_FILE_NO_MK: String?
    let RCP_PARTS_DTLS: String? // 재료정보
    let instructions: [Instruction]

    enum CodingKeys: String, CodingKey {
        case RCP_SEQ, RCP_NM, RCP_WAY2, RCP_PAT2, INFO_WGT, INFO_ENG, INFO_CAR, INFO_PRO, INFO_FAT, INFO_NA, HASH_TAG
        case ATT_FILE_NO_MAIN, ATT_FILE_NO_MK, RCP_PARTS_DTLS
    }

    // Custom Decoding Logic
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        RCP_SEQ = try container.decode(String.self, forKey: .RCP_SEQ)
        RCP_NM = try container.decode(String.self, forKey: .RCP_NM)
        RCP_WAY2 = try container.decode(String.self, forKey: .RCP_WAY2)
        RCP_PAT2 = try container.decode(String.self, forKey: .RCP_PAT2)
        INFO_WGT = try? container.decode(String.self, forKey: .INFO_WGT)
        INFO_ENG = try? container.decode(String.self, forKey: .INFO_ENG)
        INFO_CAR = try? container.decode(String.self, forKey: .INFO_CAR)
        INFO_PRO = try? container.decode(String.self, forKey: .INFO_PRO)
        INFO_FAT = try? container.decode(String.self, forKey: .INFO_FAT)
        INFO_NA = try? container.decode(String.self, forKey: .INFO_NA)
        HASH_TAG = try? container.decode(String.self, forKey: .HASH_TAG)
        ATT_FILE_NO_MAIN = try? container.decode(String.self, forKey: .ATT_FILE_NO_MAIN)
//        ATT_FILE_NO_MK = try? container.decode(String.self, forKey: .ATT_FILE_NO_MK)
        RCP_PARTS_DTLS = try? container.decode(String.self, forKey: .RCP_PARTS_DTLS)

        // Decode instructions
        var steps: [Instruction] = []
        for i in 1...20 {
            let key = "MANUAL\(String(format: "%02d", i))"
            let imageKey = "MANUAL_IMG\(String(format: "%02d", i))"
            if let step = try? container.decodeIfPresent(String.self, forKey: CodingKeys(stringValue: key)!),
               !step.isEmpty {
                let image = try? container.decodeIfPresent(String.self, forKey: CodingKeys(stringValue: imageKey)!)
                steps.append(Instruction(stepNumber: i, description: step, imageURL: image))
            }
        }
        instructions = steps
    }

    // Custom Encoding Logic
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(RCP_SEQ, forKey: .RCP_SEQ)
        try container.encode(RCP_NM, forKey: .RCP_NM)
        try container.encode(RCP_WAY2, forKey: .RCP_WAY2)
        try container.encode(RCP_PAT2, forKey: .RCP_PAT2)
        try container.encodeIfPresent(INFO_WGT, forKey: .INFO_WGT)
        try container.encodeIfPresent(INFO_ENG, forKey: .INFO_ENG)
        try container.encodeIfPresent(INFO_CAR, forKey: .INFO_CAR)
        try container.encodeIfPresent(INFO_PRO, forKey: .INFO_PRO)
        try container.encodeIfPresent(INFO_FAT, forKey: .INFO_FAT)
        try container.encodeIfPresent(INFO_NA, forKey: .INFO_NA)
        try container.encodeIfPresent(HASH_TAG, forKey: .HASH_TAG)
        try container.encodeIfPresent(ATT_FILE_NO_MAIN, forKey: .ATT_FILE_NO_MAIN)
//        try container.encodeIfPresent(ATT_FILE_NO_MK, forKey: .ATT_FILE_NO_MK)
        try container.encodeIfPresent(RCP_PARTS_DTLS, forKey: .RCP_PARTS_DTLS)

        // Encode instructions
        for instruction in instructions {
            let key = "MANUAL\(String(format: "%02d", instruction.stepNumber))"
            let imageKey = "MANUAL_IMG\(String(format: "%02d", instruction.stepNumber))"
            try container.encode(instruction.description, forKey: CodingKeys(stringValue: key)!)
            if let imageURL = instruction.imageURL {
                try container.encode(imageURL, forKey: CodingKeys(stringValue: imageKey)!)
            }
        }
    }
}

// Instruction Struct
struct Instruction: Codable {
    let stepNumber: Int // 조리 순서
    let description: String // 설명
    let imageURL: String? // 해당 조리의 이미지
}
