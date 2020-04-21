import Foundation
import Alamofire

final class NetworkHelper {

    let share = NetworkHelper()
    let baseURL = "https://api.github.com/"

    func fetchGithubRepos(language: String, sort: String) -> DataRequest? {

        let keyPath = "search/repositories"
        guard let url = URL(string: baseURL + keyPath) else { return nil }
        let parameters = ["p": language,
                          "sout": sort]

        return Alamofire.request(url,
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
                        print(repositories)
                    } catch let error {
                        print(error)
                    }
                }
        }
    }
}
