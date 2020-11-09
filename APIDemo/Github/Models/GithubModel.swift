import Foundation

struct Repositories: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [Repository]?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct Repository: Codable {
    let name: String
    let id: Int
    let fullName: String
    let owner: User
    let description: String?
    let language: String?
    let starCount: Int
    let forksCount: Int

    enum CodingKeys: String, CodingKey {
        case id, owner, description, language, name
        case fullName = "full_name"
        case starCount = "stargazers_count"
        case forksCount = "forks_count"
    }
}

struct User: Codable {
    let login: String
    let id: Int
    let avatarURL: String?
    let url: String?
    let name: String?
    let followers: Int?
    let following: Int?
    let createdAt: String?
    let updatedAt: String?
    let company: String?
    let email: String?
    let location: String?

    enum CodingKeys: String, CodingKey {
        case login, id, url, name, email, followers, following, location, company
        case avatarURL = "avatar_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
