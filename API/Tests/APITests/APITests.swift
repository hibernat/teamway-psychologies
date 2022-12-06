import XCTest
@testable import API

final class APITests: XCTestCase {
    
    func testMakeGetRequest() throws {
        let request = try TestAPI.getSomething.makeURLRequest()
        XCTAssertEqual(request.url?.absoluteString, TestAPI.baseUrlText + TestAPI.path)
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.allHTTPHeaderFields, TestAPI.headers)
    }
    
    func testMakePostRequest() throws {
        let field = "field"
        let value = "value"
        let request = try TestAPI
            .postSomething(parameters: [field : value])
            .makeURLRequest()
        XCTAssertEqual(request.url?.absoluteString, TestAPI.baseUrlText + TestAPI.path)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.allHTTPHeaderFields, TestAPI.headers)
        guard let body = request.httpBody else {
            XCTFail("httpBody does not contain encoded parameters")
            return
        }
        let bodyParameters = try JSONDecoder().decode([String : String].self, from: body)
        XCTAssertEqual(bodyParameters[field], value)
    }
}
