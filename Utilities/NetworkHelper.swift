import Foundation
import Alamofire

final class NetworkHelper {

    static let share = NetworkHelper()
    let baseURL = "https://api.github.com/"

    func fetchGithubRepos(language: String,
                          sort: String,
                          page: Int,
                          success: @escaping (Repositories) -> Void) {
        let keyPath = "search/repositories"
        guard let url = URL(string: baseURL + keyPath) else { return }
        let parameters: [String: Any] = ["q": language,
                                         "sort": sort,
                                         "page": page,
                                         "per_page": 10]

        Alamofire.request(url,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.queryString,
                          headers: nil)
            .responseData { (response) in
                switch response.result {
                case.failure(let error):
                    print(error)
                case .success(let data):
                    do {
                        let repositories = try JSONDecoder().decode(Repositories.self, from: data)
                        success(repositories)
                    } catch let error {
                        print(error)
                    }
                }
        }
    }
}
