// ----------------------------------------------------------------------------
//
//  RPCResponse.swift
//
//  @author Denis Kolyasev <kolyasev@gmail.com>
//
// ----------------------------------------------------------------------------

class Response
{
// MARK: Construction

    init(response: Any) throws
    {
        guard let json = (response as? [String: AnyObject]),
              let version = (json[JsonKeys.JsonRPC] as? String), (version == RPCClient.Version),
              let id = (json[JsonKeys.Id] as? String)
        else {
            throw ResponseError.invalidFormat
        }

        // Handle 'id' object
        self.id = id

        // Handle 'result' object if exists
        if let result = json[JsonKeys.Result]
        {
            // Create success result body
            self.body = .success(result: result)
        }
        else
        // Handle 'error' object if exists
        if let error   = (json[JsonKeys.Error] as? [String: Any]),
           let code    = (error[JsonKeys.Code] as? Int),
           let message = (error[JsonKeys.Message] as? String)
        {
            let data = error[JsonKeys.Data]

            // Init JSON-RPC error
            let error = RPCError(code: code, message: message, data: data)

            // Create error body
            self.body = .error(error: error)
        }
        else {
            throw ResponseError.invalidFormat
        }
    }

// MARK: - Properties

    let id: String

    let body: Body

// MARK: - Inner Types

    enum Body
    {
        case success(result: AnyObject)
        case error(error: RPCError)
    }

// MARK: Constants

    fileprivate struct JsonKeys
    {
        static let JsonRPC = "jsonrpc"
        static let Method = "method"
        static let Params = "params"
        static let Result = "result"
        static let Error = "error"
        static let Code = "code"
        static let Message = "message"
        static let Data = "data"
        static let Id = "id"
    }

}

// ----------------------------------------------------------------------------

enum ResponseError: Error
{
    case invalidFormat
}

// ----------------------------------------------------------------------------
