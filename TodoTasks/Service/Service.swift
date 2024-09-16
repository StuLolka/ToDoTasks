import Foundation
import Alamofire

class Service {

    private let urlString = "https://dummyjson.com/todos"
    private var url: URL? {
        let url = URL(string: urlString)
        return url
    }

}

//MARK: - ServiceProtocol
extension Service: ServiceProtocol {

    func fetchTasks(completion: @escaping (TodoModel) -> ()) {
        guard let url else { return }

        AF.request(url)
            .validate()
            .responseDecodable(of: TodoModel.self) { response in
                guard let model = response.value else { return }
                completion(model)
            }.resume()
    }

}
