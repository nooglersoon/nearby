import Foundation

public protocol HTTPClient {
    func execute(
        with request: URLRequest
    ) async -> Result<HTTPResponse, HTTPError>
    
    func execute<ResponseBody: Decodable>(
        with request: URLRequest,
        for: ResponseBody.Type
    ) async -> Result<(ResponseBody?, HTTPResponse), HTTPError>
}
